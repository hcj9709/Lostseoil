
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Appchat.dart';

class MychatRoom extends StatefulWidget{
  String name;
  int student_id;
  MychatRoom({Key? key,required this.name,required this.student_id }) : super(key: key);
  @override
  MychatRooms createState() => MychatRooms();

}
class MychatRooms extends State<MychatRoom> {
  final List<String> imagefile =<String>["","","","","",""] ;
  int ListSize=0;
  final List<String> writeDate=<String>[];
  final List<String> Title=<String>[];
  final List<String> Title2=<String>[];
  final List<String> content=<String>[];
  final List<String> LostIndex = <String>[];
  var nowdate = DateTime.now();
  Future <void> MyPosting()async {
    try {
      Dio dio = Dio();

      var data = {'userid':widget.student_id.toString()};

      var body = json.encode(data); //데이타 피라미터를 json 인코드함

      Response response = await dio.post('http://wnsgnl97.myqnapcloud.com:3001/api/chat/chatList',
          data:body);

      setState((){

        print("셋 스테이트");//돌아가는지 확인 하기위해 사용
        if (response.statusCode==200) {
          for(int i =0 ; i<response.data.length;i++){
            print(response.data);
            Title.add(response.data[i]['name']);
            Title2.add(response.data[i]['attend']);
            content.add(response.data[i]['msg']);

            LostIndex.add(response.data[i]['room_id']);

          //  print((writeDate[0].split(" ")));
          //  print(DateFormat("yyyy-MM-dd").format(nowdate));
          //  print((response.data[0]['chat_time'].split(" ")[0])==(DateFormat("yyyy-MM-dd").format(nowdate)));

            if((response.data[i]['chat_time'].split(" ")[0])==(DateFormat("yyyy-MM-dd").format(nowdate)))
              {
                writeDate.add(response.data[i]['chat_time'].split(" ")[1]);
              }
            else{
               writeDate.add(response.data[i]['chat_time'].split(" ")[0]);
            }
            ListSize++;
          }
        }
      });

    } catch (e) {
      print("서버에러");
    }
    finally{

    }

  }
  @override
  void initState(){
    MyPosting();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size? size = MediaQuery.maybeOf(context)?.size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
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
  body:SingleChildScrollView(

      child: ListView.builder(
          padding: const EdgeInsets.all(0),
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: ListSize, //이거 길이만큼 리스트타일을 보여줌
          itemBuilder: (BuildContext context, int index) {
            return
              SingleChildScrollView(
                child:Container(

                  width: MediaQuery.of(context).size.width,
                  child:Column(
                      children:[
                        ListTile(

                    leading:  Column(
                          children: [
                            if( imagefile[index]!="null"  )...[
                              Container(
                                margin: EdgeInsets.all(0),
                                width:55,
                                height:56,
                                child : ClipRRect(
                                    borderRadius: BorderRadius.circular(3.0),
                                    child: Icon(Icons.people)
                                  //Image.network(imagefile[index],fit: BoxFit.cover,) // Text(key['title']),
                                ),

                              ),
                            ]
                            else...[
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 15),
                                  child:Text("사진없당")
                              ),
                            ],
                          ],
                        )
                          ,//DB에 저장된 이미지 받고
                          title:  Text(Title2[index].toString()+" "+Title[index]),//DB에 저장된 타이틀 값 받고
                          trailing: Text(writeDate[index],style: TextStyle(color: Colors.grey),),
                          subtitle:  Text(content[index],style: TextStyle(color:Colors.lightBlue,overflow: TextOverflow.ellipsis,),),//등록일자 받고
                          onTap: () {

                            Navigator.push(context,MaterialPageRoute(builder:(context)=>
                                mychat(student_id: widget.student_id,
                                    name: widget.name,
                                    room_id:LostIndex[index])));
                          },

                        ),
                        const Divider(color: Colors.grey,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,)
                      ]

                  ),
                )
            );
          }
      ),
  )
    )
    ;
  }


}