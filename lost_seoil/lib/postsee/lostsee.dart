
import 'dart:convert';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lost_seoil/Write/Writeupdate.dart';

import '../Chat/ChatRoom.dart';
import '../Dialog/DeleteDialog.dart';
import '../Dialog/dialog.dart';
import '../Dialog/reportDialog.dart';
import '../mainform/lostgetpage.dart';
import '../mainform/lostseoild_mainform.dart';

class Lostsee extends StatefulWidget{
  int LostIndex;
  int student_id;
  String name;
  Lostsee({Key? key,required this.LostIndex,required this.student_id , required this.name}) : super(key: key);
  @override
  MyLostsee createState() => MyLostsee();
}

class MyLostsee extends State<Lostsee> {
  var formatter = DateFormat("yyyy-MM-dd");
  String galleryname="";
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
  String Imagefile = "null";
  int commentsieze = 0;
  final List<String> Comments = <String>[];
  final List<String> Commentsname = <String>[];
  final List<int> Commentsstudent_id = <int>[];
  final List<String> CommentsTime = <String>[];
  final List<int> Commentid = <int>[];
  int commentcount = 0;
  int is_complete = 0;
  var appbarTextcolor= Colors.white;
  var Textcolor= Colors.black;
  int losttype=0;

  @override
  initState()   {
    PostIndex();
    commentget();
    super.initState();
    //postHttp();

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

      name= jsonEncode(response.data[0]['name']).replaceAll("\"", "");

      LostDate=  jsonEncode(response.data[0]['lostdate']).replaceAll("\"", "");

      Time= jsonEncode(response.data[0]['time']).replaceAll("\"", "");


      content = jsonEncode(response.data[0]['content']).replaceAll("\"", "");



      LostLocation = jsonEncode(response.data[0]['location']).replaceAll("\"", "");
      category = jsonEncode(response.data[0]['category']).replaceAll("\"", "");
      is_complete = response.data[0]['is_complete'];
      if(is_complete==1){
        appbarTextcolor=Colors.grey;
        Textcolor= Colors.grey;
      }
      if(response.data[0]['image']!= 'null'){
        print(response.data[0]['image']);
        Imagefile = jsonEncode(response.data[0]['image']).replaceAll("\"", "");
      }
     galleryname = (response.data[0]['losttype'] != 1)? "습득물":"분실물";
      losttype = response.data[0]['losttype'];
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
            commentcount++;
            Commentid.add(response.data[i]['id']);
          }
          print("댓글 불러오기 성공");
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
  Future<bool> PostComment()  async { //함수내용은 Dio 이나 이름을 바꾸지 않았음
    try {
      Dio dio = Dio();
//학번 댓글 내용 게시글번호
      var data = {'student_id':widget.student_id,'content':comment.text,'posting_id':widget.LostIndex};
      var body = json.encode(data); //데이타 피라미터를 json 인코드함
      Response response = await dio.post('http://wnsgnl97.myqnapcloud.com:3001/api/posting/makeComment',
          data:body);

      print("에러발견");
       setState((){
        print("포스트");//돌아가는지 확인 하기위해 사용
        if (response.statusCode==200) {
          print("댓글 올리기 성공");
        }
        else{

          print("글올리기실패");

        }
      });

    } catch (e) {
      print("서버에러");
    }
    finally{

    }
    return false;
  }

 //삭제 다이얼로그
  Future<void>  DeleteDialog(BuildContext context ,StateSetter setState) async {
    await showDialog<void>(
        context: context ,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: true,

        builder:(BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(15), //다이얼로그 박스에 대한 패딩
            titlePadding: const EdgeInsets.all(0), //타이틀에대한 패딩
            //contentPadding: const EdgeInsets.all(8), //글 내용에 대한 패딩
            contentPadding: const EdgeInsets.only(top: 0, left: 8,right: 8, bottom: 0),
            actionsPadding:const EdgeInsets.all(0) ,//action거기에 대한 패딩

            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.0)),
            //Dialog Main Title

            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children:   <Widget>[
                Container(
                    margin: EdgeInsets.all(20),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child:Text("삭제 확인"
                        )
                    )
                ),
              ],

            ),

            content:GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },

                child:SingleChildScrollView(
                  child:StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("정말로 삭제 하시겠습니까?")
                          ],
                        );
                      }
                  ),
                )
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              TextButton(
                child: const Text("확인"),
                onPressed: () {
                  DeletePost();
                  Navigator.pop(context);
                },
              ),

            ],
          );
        });
  }

  Future<bool> DeletePost() async{
    Dio dio = Dio();
    var data = {'id':widget.LostIndex};
    var body = json.encode(data);

    Response response = await dio.delete('http://wnsgnl97.myqnapcloud.com:3001/api/posting/deletePosting'
        ,data:body
    );

    setState((){
      print("셋 스테이트");//돌아가는지 확인 하기위해 사용

      if (response.statusCode==200) {
        print("삭제");
        Navigator.push(context,MaterialPageRoute(builder:(context)=> MyApp(name: widget.name ,student_id: widget.student_id )));


      }
      else{
        print("삭제실패");
      }
    });
    return false;
  }

  Future<bool> DeleteComment(int Commentid) async{
    Dio dio = Dio();
    var data = {'id': Commentid};
    var body = json.encode(data);
    print(Commentid);

    Response response = await dio.delete('http://wnsgnl97.myqnapcloud.com:3001/api/posting/deleteComment'
        ,data:body
    );

    setState((){
      print("셋 스테이트");//돌아가는지 확인 하기위해 사용

      if (response.statusCode==200) {
        print("삭제");
        showToast('댓글삭제');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => super.widget));
      }
      else{
        print("삭제실패");
      }
    });
    return false;
  }



  Future<void>  CompleteDialog(BuildContext context ,StateSetter setState) async {
    await showDialog<void>(
        context: context ,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: true,

        builder:(BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(15), //다이얼로그 박스에 대한 패딩
            titlePadding: const EdgeInsets.all(0), //타이틀에대한 패딩
            //contentPadding: const EdgeInsets.all(8), //글 내용에 대한 패딩
            contentPadding: const EdgeInsets.only(top: 0, left: 8,right: 8, bottom: 0),
            actionsPadding:const EdgeInsets.all(0) ,//action거기에 대한 패딩

            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.0)),
            //Dialog Main Title

            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children:   <Widget>[
                Container(
                    margin: EdgeInsets.all(20),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child:Text("완료처리"
                        )
                    )
                ),
              ],

            ),

            content:GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },

                child:SingleChildScrollView(
                  child:StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("정말로 완료 처리 하시겠습니까?")
                          ],
                        );
                      }
                  ),
                )
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              TextButton(
                child: const Text("완료"),
                onPressed: () {
                  CompletePost();
                  Navigator.pop(context);
                },
              ),

            ],
          );
        });
  }

  Future<bool> CompletePost() async{
    Dio dio = Dio();
    var data = {'id':widget.LostIndex};
    var body = json.encode(data);

    Response response = await dio.put('http://wnsgnl97.myqnapcloud.com:3001/api/posting/updatePosting'
        ,data:body
    );

    setState((){
      print("셋 스테이트");//돌아가는지 확인 하기위해 사용

      if (response.statusCode==200) {
        print("삭제");

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => super.widget));

      }
      else{
        print("삭제실패");
      }
    });
    return false;
  }

  Future<bool> chatStart() async{
    Dio dio = Dio();
    var data = {'user1':widget.student_id,'user2':student_id};
    var body = json.encode(data);

    Response response = await dio.post('http://wnsgnl97.myqnapcloud.com:3001/api/chat/chatRoom'
        ,data:body
    );
    print("123");
    setState((){
      print("셋 스테이트");//돌아가는지 확인 하기위해 사용

      if (response.statusCode==200) {
        print("채팅방 생성");
        Navigator.push(context,MaterialPageRoute(builder:(context)=>  MychatRoom(student_id: widget.student_id, name: widget.name,)));

      }
      else{
        print("채팅방 존재");
        Navigator.push(context,MaterialPageRoute(builder:(context)=>  MychatRoom(student_id: widget.student_id, name: widget.name,)));

      }
    });
    return false;
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   MaterialApp(
      home:Scaffold(
        resizeToAvoidBottomInset: false ,
        appBar:AppBar(
          title:  Text(galleryname+" 게시판"),
          leading:  IconButton(
            icon: const Icon(Icons.arrow_back_ios),color:Colors.white, onPressed: () {
              if(losttype==1) {
                Navigator.push(context,MaterialPageRoute(builder:(context)=> MyApp(name: widget.name ,student_id: widget.student_id )));
              }else{
                Navigator.push(context,MaterialPageRoute(builder:(context)=> GetPage(name: widget.name ,student_id: widget.student_id )));
              }
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
                    Text(galleryname+" > "+category,style: const TextStyle(color: Colors.lightBlue,fontSize: 8),),

                  ],
                ),
                Container(
                  height: 22,
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                        Text(Title,style: TextStyle(color: Textcolor),),
                   if((widget.student_id.toString())==(student_id.toString()))...[
                     PopupMenuButton(
                       padding: EdgeInsets.fromLTRB(5,0,3, 7),
                         icon: Icon(Icons.more_vert_outlined,size: 20,color: Textcolor,),
                       itemBuilder: (context)=>[
                         PopupMenuItem(child: Text("게시글 수정")
                           ,value: 1,
                           onTap: () async{
                              await Future.delayed(Duration.zero);
                               Navigator.push(context, MaterialPageRoute(
                                   builder: (context) =>
                                       Writeupdate(name: widget.name,
                                           student_id: widget.student_id, LostIndex: widget.LostIndex,)));
                           }),
                         PopupMenuItem(child: Text("게시글 삭제")
                           ,value: 2,
                           onTap: (){
                             print("삭제");
                             DeleteDialog(context,setState);
                           },
                         ),
                         PopupMenuItem(child: Text("완료처리")
                           ,value: 2,
                           onTap: (){
                             print("완료");
                             CompleteDialog(context,setState);
                           },
                         ),
                       ],
                     )

                  ],
                ]
                ),),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton(
                      child: Text("작성자 : "+student_id+"_"+name, style: TextStyle(fontSize: 12, color: Textcolor) ,),
                      itemBuilder: (context)=>[
                        if(widget.student_id != int.parse(student_id))...[
                        PopupMenuItem(child: Text("1:1대화")
                          ,value: 1,
                          onTap: (){print("대화"); chatStart();},
                        ),
                        PopupMenuItem(child: Text("신고하기")
                          ,value: 2,
                          onTap: (){
                          print("레포트");
                          ReportDialog(context,setState);
                          },
                        ),
                        ],
                      ],


                    ),
                    Text(Time,style: TextStyle(fontSize: 12, color: Textcolor))
                  ],
                ),
                const Divider(
                  height: 2,
                  color: Colors.black,

                ),
                Container(
                  height: 10,
                ),
              if( Imagefile!='null')...[
                Container(
                    height: 270,
                    child: Image.network(Imagefile)
                ),
              ]
              else...[
               Container(
                 height: 50,
                  ),
                    ],
                Row(
                  children: [
                    RichText(
                        text:   TextSpan(
                            style: TextStyle(fontSize: 12, color: Textcolor) ,
                            children:<TextSpan>[
                               TextSpan(text: '분실일자 : ', style: TextStyle(fontWeight: FontWeight.bold,color: Textcolor)),
                              TextSpan(text: LostDate,style:TextStyle(color: Textcolor)),
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
                              TextSpan(text: '분실장소 : ', style: TextStyle(fontWeight: FontWeight.bold,color: Textcolor)),
                              TextSpan(text: LostLocation.replaceAll("\"", ""),style: TextStyle(color: Textcolor)),
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
                        text:    TextSpan(
                            style:TextStyle(fontSize: 12, color: Textcolor) ,
                            children:<TextSpan>[
                              TextSpan(text: '특이사항 : ', style: TextStyle(fontWeight: FontWeight.bold,color: Textcolor)),
                              //TextSpan(text:StringTime.toString()),

                            ]
                        )
                    ),
                    Expanded(
                     child:Text(content,     maxLines: 3,
                         textAlign: TextAlign.left,
                      softWrap: true,   overflow: TextOverflow.clip  ,style: TextStyle(color: Textcolor),)
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
                            children: [
                                      Text("댓글 "),
                                      Text(commentcount.toString()),
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
                                              Container(
                                                child:Column(

                                                children:[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:[
                                                        Image.asset('assets/images/banana.png',width: 40, height: 40),
                                                        Text(" "),
                                                        Text(" "),
                                                  ]
                                                     ),
                                                        Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        Container(
                                                          height: 22,
                                                            width: MediaQuery.of(context).size.width-60,
                                                          child:Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children:[
                                                                PopupMenuButton(
                                                                  child: Text(Commentsstudent_id[index].toString() + Commentsname[index],style:TextStyle(fontSize: 12,)),
                                                                  itemBuilder: (context)=>[
                                                                    PopupMenuItem(child: Text("1:1대화")
                                                                      ,value: 1,
                                                                      onTap: (){print("1:1대화");
                                                                      },
                                                                    ),
                                                                    PopupMenuItem(child: Text("신고하기")
                                                                      ,value: 2,
                                                                      onTap: (){print("1:1대화");},
                                                                    ),
                                                                  ],
                                                                ),
                                                                if((widget.student_id.toString())==(student_id.toString()))...[
                                                                  PopupMenuButton(
                                                                    padding: EdgeInsets.fromLTRB(5,0,3, 7),
                                                                    icon: Icon(Icons.more_vert_outlined,size: 20,),
                                                                    itemBuilder: (context)=>[
                                                                      PopupMenuItem(child: Text("댓글 삭제")
                                                                        ,value: 2,
                                                                        onTap: (){
                                                                          print("댓글삭제");
                                                                          DeleteComment(Commentid[index]);

                                                                        },
                                                                      ),

                                                                    ],
                                                                  )

                                                                ],
                                                              ]
                                                          ),),

                                                        Text(CommentsTime[index],style: TextStyle(fontSize: 10,color: Colors.grey),)
                                                         , Text("\n"+Comments[index]+"\n"
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
                    onTap: (){
                     if(comment.text!=""){
                       print(comment.text);
                       print("send");
                      PostComment();
                       Navigator.pushReplacement(
                           context,
                           MaterialPageRoute(
                               builder: (BuildContext context) => super.widget));

                     }
                     else{
                       print("빈칸x");
                     }

                    }
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
      ),

    );


  }
}
void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.lightBlue,
      textColor: Colors.white,
      fontSize: 16.0);
}