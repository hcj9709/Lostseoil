
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
class mychat extends StatefulWidget{
  int LostIndex;
  int student_id;
  mychat({Key? key,required this.LostIndex,required this.student_id }) : super(key: key);
  @override
  Chatstart createState() => Chatstart();

}
class Chatstart extends State<mychat> {
   late TextEditingController _messageController;
   late ScrollController _controller;
   late IO.Socket socket;

   @override
   void initState() {
     super.initState();
     initializeSocket(); //--> call the initializeSocket method in the initState of our app.
   }
   void initializeSocket() {
     socket =
         io("http://wnsgnl97.myqnapcloud.com:3001", <String, dynamic>{
           "transports": ["websocket"],
           "autoConnect": false,
         });
     socket.connect();  //connect the Socket.IO Client to the Server

     //SOCKET EVENTS
     // --> listening for connection
     socket.on('connect', (data) {
       print(socket.connected);
     });

     //listen for incoming messages from the Server.
     socket.on('message', (data) {
       print(data); //
     });

     //listens when the client is disconnected from the Server
     socket.on('disconnect', (data) {
       print('disconnect');
     });
   }
   @override
   void dispose() {
     socket.disconnect(); // --> disconnects the Socket.IO client once the screen is disposed
     super.dispose();
   }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     body: Form(
       child: Column(
       children: [

       ],
     ),

     ),

   );

  }


}
