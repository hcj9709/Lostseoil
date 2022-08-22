
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
class mychat extends StatefulWidget{
  String name;
  int student_id;
  String room_id;
  mychat({Key? key,required this.name,required this.student_id,required this.room_id }) : super(key: key);
  @override
  Chatstart createState() => Chatstart();

}
class Chatstart extends State<mychat> {

  TextEditingController chat = TextEditingController();
  ScrollController scroll = ScrollController();
  late IO.Socket socket;
  @override
  void initState(){
    super.initState();
    chat = TextEditingController();
    scroll = ScrollController();
    initSocket();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scroll.animateTo(0.0, duration: Duration(milliseconds: 20),
          curve: Curves.easeIn
      );
    });
    focusManager();
  }

  Future<void> initSocket() async {
  try{
    /*
    Dio dio = Dio();

    var data = {'room_id':widget.room_id};

    var body = json.encode(data); //데이타 피라미터를 json 인코드함

    Response response = await dio.post('http://wnsgnl97.myqnapcloud.com:3001/api/chat/roomChatting',
        data:body);

    MessagesModel.messages.addAll(response.data);
    print( MessagesModel.messages);
    print( MessagesModel.messages[0]);
  */

    socket = IO.io('http://wnsgnl97.myqnapcloud.com:3001',
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        });

    socket.connect();

    socket.on('connect', (data) {
      print('connect');
      socket.emit(
          'login', {'name': widget.name, 'userid': widget.student_id,
      'room_id':widget.room_id});
      setState(() {
      });
    });
    socket.on('chatData',(data){

      print(data);

      MessagesModel.messages.addAll(data);

      print(data[0]['userid']);
      print(data[0]['msg']);
    });

    socket.on('login',
            (data)=>
       print(data)
    );


    socket.on('chat', (message) {
      print(message);

      setState(() {
        MessagesModel.messages.add(message);

      });
    });





    /*
    socket.emit('connection', {'name': widget.name, 'userid': widget.student_id});

    socket.onConnect((_){
      print('connect');

    });
    */

    /*socket.emit('connection', {'name': widget.name, 'userid': widget.student_id});
    socket.connect();
    socket.on('connection', (_) {
      print('connect');
     // print(socket.io.engine.id);
       });

    socket.on('newChat', (message) {
      print(message);
      setState(() {
        MessagesModel.messages.add(message);
      });
    });

    socket.on('allChats', (messages) {
      setState(() {
        MessagesModel.messages.addAll(messages);
      });
    });
    */
  }
  catch(_){
    print("에러");
  }

  }
  var focusNode = FocusNode();

  focusManager() async {
    await Future.delayed(Duration(milliseconds: 500));
    focusNode.requestFocus();
  }
  @override
  void dispose(){
    chat.dispose();
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }
  void _sendMessage(){
    String messageText = chat.text.trim();
    chat.text='';
    //print(messageText);
    if(messageText!=''){
      var messagePost ={
        'msg':messageText,
        //'recipient':'chat',
        //'time':DateTime.now().toUtc().toString().substring(0,16)
      };
      socket.emit('chat',messagePost);
    }
  }
  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.maybeOf(context)?.size;
    // TODO: implement build
   return Scaffold(
     backgroundColor: Colors.grey[300],
     appBar: AppBar(
       backgroundColor: Colors.lightBlue,
       leading: IconButton(
         icon: Icon(Icons.arrow_back),
         color: Colors.white,
         onPressed: () {
           socket.onDisconnect((_) => print('disconnect'));
           Navigator.pop(context);
         },
       ),
       title: Row(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
             width: size!.width * 0.60,
             child: Container(
               child: Text(
                 '채팅방',
                 style: TextStyle(fontSize: 15, color: Colors.white),
                 textAlign: TextAlign.left,
               ),
             ),
           ),
         ],
       ),
     ),
     body:      GestureDetector(
         onTap: () {
           FocusScope.of(context).unfocus();
         },
     child:Stack(

         children: [

           Positioned(
             top: 0,
             bottom: 60,
             width: size.width,
             child: ListView.builder(
               controller: scroll,
               scrollDirection: Axis.vertical,
               shrinkWrap: true,
               reverse: true,
               cacheExtent: 10000,
               itemCount: MessagesModel.messages.length,
               itemBuilder: (BuildContext context, int index) {

                 var message = MessagesModel.messages[MessagesModel.messages.length - index - 1];
                 return (message['userid'] == widget.student_id )
                     ? ChatBubble(
                   clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                   alignment: Alignment.topRight,
                   margin: EdgeInsets.only(top: 5, bottom: 5),
                   backGroundColor: Colors.yellow[100],
                   child: Container(
                     constraints: BoxConstraints(maxWidth: size.width * 0.7),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        // Text('@${message['time']}', style: TextStyle(color: Colors.grey, fontSize: 10)),
                         Text('${message['msg']}', style: TextStyle(color: Colors.black, fontSize: 16))
                       ],
                     ),
                   ),
                 )
                     : ChatBubble(
                   clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                   alignment: Alignment.topLeft,
                   margin: EdgeInsets.only(top: 5, bottom: 5),
                   backGroundColor: Colors.grey[100],
                   child: Container(
                     constraints: BoxConstraints(maxWidth: size.width * 0.7),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('${message['name']} ', style: TextStyle(color: Colors.grey, fontSize: 10)),
                         Text('${message['msg']}', style: TextStyle(color: Colors.black, fontSize: 16))
                       ],
                     ),
                   ),
                 );
               },
             ),
           ),
           Positioned(
             bottom: 0,
             child: Container(
               height: 60,
               color: Colors.white,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Container(
                     width: size.width*0.80,
                     padding: EdgeInsets.only(left: 10, right: 5),
                     child: TextField(
                        focusNode:focusNode ,
                       controller: chat,
                       cursorColor: Colors.black,
                       decoration: InputDecoration(
                         hintText: "Message",
                         labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                         enabledBorder: UnderlineInputBorder(
                           borderSide: BorderSide(color: Colors.black),
                         ),
                         focusedBorder: UnderlineInputBorder(
                           borderSide: BorderSide(color: Colors.black),
                         ),
                         disabledBorder: UnderlineInputBorder(
                           borderSide: BorderSide(color: Colors.grey),
                         ),
                         counterText: '',
                       ),
                       style: TextStyle(fontSize: 15),
                       keyboardType: TextInputType.text,
                       maxLength: 500,
                     ),
                   ),
                   Container(
                     width: size.width * 0.20,
                     child: IconButton(
                       icon: Icon(Icons.send, color: Colors.lightBlue),
                       onPressed: () {
                         _sendMessage();
                       },
                     ),
                   )
                 ],
               ),
             ),
           )

         ],
       ),

)

   );

  }


}
class MessagesModel {
  static final List<dynamic> messages = [];

  static updateMessages(dynamic message) async {
    messages.add(message);
  }
}
