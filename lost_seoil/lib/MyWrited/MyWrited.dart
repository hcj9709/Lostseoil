
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../postsee/lostsee.dart';

class Writed extends StatefulWidget {
  String name;
  int student_id;
  Writed({Key? key,required this.student_id , required this.name}) : super(key: key);

  @override
  MyWrited createState() => MyWrited();
}

class MyWrited extends State<Writed> {
  int ListSize=0;
  final List<String> writeDate=<String>[];
  final List<String> Title=<String>[];
  final List<int> is_complete =<int>[];
  final List<int> LostIndex = <int>[];
  @override
  void initState(){
    super.initState();
    MyPosting();
  }
  Future <void> MyPosting()async {
    try {
      Dio dio = Dio();
      Response response = await dio.get('http://wnsgnl97.myqnapcloud.com:3001/api/posting/viewMyPosting',
          queryParameters: {
            'student_id':widget.student_id,
          }
      );
      setState((){
        print("셋 스테이트");//돌아가는지 확인 하기위해 사용
        if (response.statusCode==200) {
          for(int i =0 ; i<response.data.length;i++){
            print(response.data.length);
            print(response.data[0]['title'].length);
              Title.add(response.data[i]['title']);//<<여기서 오류

              writeDate.add(response.data[i]['time']);
              ListSize++;
              is_complete.add(response.data[i]['is_complete']);
            LostIndex.add(response.data[i]['id']);
            print(LostIndex[i]);
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
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: Text("내글조회"),
            leading:  IconButton(
              icon: const Icon(Icons.arrow_back_ios),color:Colors.white, onPressed: () {
              Navigator.pop(context);
            },)
        ),
        body:SingleChildScrollView(
          child:Container(
          child:Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemCount: ListSize, //이거 길이만큼 리스트타일을 보여줌
                  itemBuilder: (BuildContext context, int index) {
                    return  SingleChildScrollView(
                        child:Container(
                          width: MediaQuery.of(context).size.width,
                          child:Column(
                              children:[
                                ListTile(
                                  title:  Text(Title[index], style: const TextStyle(fontSize: 15,color: Colors.black),),//DB에 저장된 타이틀 값 받고
                                  subtitle:  Text(writeDate[index],style: const TextStyle(color:Colors.lightBlue),),//등록일자 받고
                                  onTap: () {
                                    Navigator.push(context,MaterialPageRoute(builder:(context)=>   Lostsee(LostIndex:LostIndex[index],student_id: widget.student_id, name: widget.name,)));
                                  },
                                  trailing: Chip(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    backgroundColor: Colors.lightBlue,
                                     label:  Container(
                                       margin: EdgeInsets.fromLTRB(0, 0,3, 0),
                                       width: 34,

                                       child:Row(
                                     children:[ if(is_complete[index]==1)...[
                                    Text('완료', style: TextStyle(color: Colors.white))
                                           ]else...[
                                       Text('미완료', style: TextStyle(color: Colors.white,fontSize: 12))
                                                ]                   
                                      ]
                                    ,
                                      ),
                                        )
                                      ,
                                  ),
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
            ],
          ),
          ),
        )
      )
    );
  }

}