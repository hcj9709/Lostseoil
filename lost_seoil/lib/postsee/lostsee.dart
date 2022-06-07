
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

import '../Dialog/dialog.dart';

class Lostsee extends StatefulWidget{
  int LostIndex;
  Lostsee({Key? key,required this.LostIndex}) : super(key: key);
  @override
  MyLostsee createState() => MyLostsee();

}

class MyLostsee extends State<Lostsee> {
  var formatter = DateFormat("yyyy-MM-dd");
   String student_id ="";
   String Title= "" ;
   String category = "전체";
   String name='' ;
   String LostDate ="" ;
   String LostLocation="" ;
   String  content="";
   // DateTime Time = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  String Time="";
  final comment = TextEditingController();
  String? Imagefile;
  int commentsieze=0;
  final List<String> Comments = <String>[];
  final List<String> Commentsname = <String>[];
  final List<int> Commentsstudent_id = <int>[];
  final List<String> CommentsTime = <String>[];
  @override
  initState()   {
    super.initState();
    //postHttp();
    PostIndex();
    commentget();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  Future<bool> PostIndex() async{
    Dio dio = Dio();
    var data = {'id':widget.LostIndex};
    var body = json.encode(data);

    Response response = await dio.post('http://wnsgnl97.myqnapcloud.com:3001/api/posting/getPosting'
        ,data:body
    );

    setState((){
      print("셋 스테이트");//돌아가는지 확인 하기위해 사용

      student_id= jsonEncode(response.data[0]['student_id']);//이걸써야 데이터 불러옰있음
      print(student_id);
      Title= jsonEncode(response.data[0]['title']).replaceAll("\"", "");
      print(Title);
      name= jsonEncode(response.data[0]['name']).replaceAll("\"", "");
      print(name);
      LostDate=  jsonEncode(response.data[0]['lostdate']).replaceAll("\"", "");
      print(LostDate);
      Time= jsonEncode(response.data[0]['time']).replaceAll("\"", "");
      print(12);

      content = jsonEncode(response.data[0]['content']).replaceAll("\"", "");

      print(content);

      LostLocation = jsonEncode(response.data[0]['location']).replaceAll("\"", "");
      category = jsonEncode(response.data[0]['category']).replaceAll("\"", "");
      if(response.data[0]['image']!=null){
        Imagefile = jsonEncode(response.data[0]['image']).replaceAll("\"", "");
      }
      print(Imagefile);


      if (response.statusCode==200) {
        print("불러오기 성공");
      }
      else{
        print("불러오기 실패");
      }
    });
    return false;
  }


  Future<bool> commentget()  async { //함수내용은 Dio 이나 이름을 바꾸지 않았음
    try {
      Dio dio = Dio();
      var data = {'posting_id':widget.LostIndex};
      var body = json.encode(data);
      Response response = await dio.post('http://wnsgnl97.myqnapcloud.com:3001/api/posting/comment',data:body);
      //텍스트필드에 2개의 값을 json을 이용하여 인코드한다음 클라이언트가 data를 보내면 서버가 data를 받고 Db에 저장된값을 보내줌
      setState((){
        if (response.statusCode==200) {
          commentsieze = response.data.length;

          for(int i = commentsieze-1; i>=0;i--){
            Comments.add(response.data[i]['content']);
            Commentsname.add(response.data[i]['name']);

            Commentsstudent_id.add(response.data[i]['student_id']);
            print(commentsieze);
            CommentsTime.add(response.data[i]['time']);
          }
          print("불러오기 성공");
        }
        else{
          print("불러오기 실패");
        }
      });
    } catch (e) {
      print("서버에러");
    }
    finally{

    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   MaterialApp(
      home:Scaffold(
        resizeToAvoidBottomInset: false ,
        appBar:AppBar(
          title: const Text("분실물 게시판"),
          leading:  IconButton(
            icon: const Icon(Icons.arrow_back_ios),color:Colors.white, onPressed: () {
            Navigator.pop(context);
          },) //글쓰기에서 뒤로가기 버튼인데 이거 나중에 보완하는것이 좋을거같음
          ,
        )
        ,
        body:   SingleChildScrollView(
          child:GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
          child:Container(
              margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),

            child: Column(
             // mainAxisAlignment :MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children:  [
                    Text("분실물 -> "+category,style: const TextStyle(color: Colors.lightBlue,fontSize: 8),)
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child:Text(Title),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton(
                      child: Text("작성자 : "+student_id+"_"+name, style:const TextStyle(fontSize: 12, color: Colors.black) ,),
                      itemBuilder: (context)=>[
                        PopupMenuItem(child: Text("1:1대화")
                          ,value: 1,
                          onTap: (){print("1:1대화");},
                        ),
                        PopupMenuItem(child: Text("신고하기")
                          ,value: 2,
                          onTap: (){print("1:1대화");},
                        ),
                      ],


                    ),
                    Text(Time,style:const TextStyle(fontSize: 12, color: Colors.black))
                  ],
                ),
                const Divider(
                  height: 2,
                  color: Colors.black,

                ),

              if(Imagefile!=null && Imagefile!='null')...[
                Container(
                    height: 270,
                    child: Image.network(Imagefile!)
                ),
              ]
              else...[
               Container(
                     height: 150,

                      child: const Text("null image")
                  ),
                    ],
                Row(
                  children: [
                    RichText(
                        text:   TextSpan(
                            style:const TextStyle(fontSize: 12, color: Colors.black) ,
                            children:<TextSpan>[
                              const TextSpan(text: '분실일자 : ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: LostDate),
                              //TextSpan(text:StringTime.toString()),

                            ]
                        )
                    ),
                  ],
                ),
                Container(
                    height: 10,
                ),
                Row(
                  children: [
                    RichText(
                        text:   TextSpan(
                            style:const TextStyle(fontSize: 12, color: Colors.black) ,
                            children:<TextSpan>[
                              const TextSpan(text: '분실장소 : ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: LostLocation.replaceAll("\"", "")),
                              //TextSpan(text:StringTime.toString()),

                            ]
                        )
                    ),
                  ],
                ),
                Container(
                  height: 10,
                ),
                Row(

                  children: [
                    RichText(
                        maxLines: 100,
                        text:   const TextSpan(
                            style:TextStyle(fontSize: 12, color: Colors.black) ,
                            children:<TextSpan>[
                              TextSpan(text: '특이사항 : ', style: TextStyle(fontWeight: FontWeight.bold)),
                              //TextSpan(text:StringTime.toString()),

                            ]
                        )
                    ),
                    Expanded(
                     child:Text(content,     maxLines: 3,
                         textAlign: TextAlign.left,
                      softWrap: true,   overflow: TextOverflow.clip  )
                    )

                  ],
                ),

                const SizedBox(
                  height: 50,
                ),

                     Container(


                        child:Align(
                            alignment: Alignment.topCenter,
                           child :Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                             children:[
                                Row(
                            children: const [
                                      Text("댓글 "),
                                      Text("N"),
                                    Text("개"),
                            ],
                          )
                               ,const Divider(
                            color: Colors.grey,

                          ),
                            Container(

                             child: ListView.builder(
                                 shrinkWrap: true,
                                 physics: NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(0),
                              itemCount: commentsieze, //이거 길이만큼 리스트타일을 보여줌
                              itemBuilder: (BuildContext context, int index) {
                                return  SingleChildScrollView(
                                    child:Container(
                                      width: MediaQuery.of(context).size.width,
                                      child:Column(
                                          children:[
                                            ListTile(   leading:   Image.asset('assets/images/banana.png',),//DB에 저장된 이미지 받고
                                              title:  Text(Comments[index]+ index.toString(), style: const TextStyle(fontSize: 10,color: Colors.black),),//DB에 저장된 타이틀 값 받고
                                              onTap: () {
                                              },

                                            ),
                                              Container(
                                                child:Column(

                                                children:[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset('assets/images/banana.png',width: 50, height: 50),
                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                      Text(Commentsstudent_id[index].toString() + Commentsname[index]+"\n",style:TextStyle(fontSize: 11,)
                                                     ),
 
                                                        Text(CommentsTime[index],style: TextStyle(fontSize: 10,color: Colors.grey),)
                                                   , Text("\n\n\n\n"+Comments[index]+ index.toString()
                                                            , style: const TextStyle(fontSize: 10,color: Colors.black),),//DB에 저장된 타이틀 값 받고

                                                      ],

                                                    )

                                                  ]
                                                ),

                                                ]
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
                            )
                        ]

                     )
                    )
                          )
              ],
            ),
          )
        ),
      ),
        bottomNavigationBar: BottomAppBar(

         child:Container(
             padding: EdgeInsets.only(
               bottom: MediaQuery.of(context).viewInsets.bottom,
             ),
          margin: EdgeInsets.fromLTRB(5, 10, 5, 10),

          child:Row(
           children:[
             Flexible(child:
                TextField(
                  controller: comment,
                  maxLines: null,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                  suffixIcon: GestureDetector(
                    child: const Icon(
                      Icons.send,
                      color: Colors.lightBlue,
                      size: 30,
                    ),
                    onTap: (){print("send");}
                  ),
                      border : OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                       ),
                       focusedBorder: OutlineInputBorder(
                       borderSide: const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                  ),
                    hintText: "댓글을 입력하세요"),
            
          ),
             ),


          ]
          )
        )

        ),
      )
    );


  }



}