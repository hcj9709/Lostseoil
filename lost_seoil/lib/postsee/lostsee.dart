
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Lostsee extends StatefulWidget{
  @override
  MyLostsee createState() => MyLostsee();

}

class MyLostsee extends State<Lostsee> {
  var formatter = DateFormat("yyyy-MM-dd");
   String student_id ="";
   String Title= "" ;
   String catefory = "전체";
  late String name ;
  late String LostDate ;
  late String LostLocation ;
  late String  content;
    DateTime Time = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  //String Time="";
  @override
  initState()   {
    super.initState();
    postHttp();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> postHttp()  async { //함수내용은 Dio 이나 이름을 바꾸지 않았음
    try {
      Dio dio = Dio();
      Response response = await dio.post('http://wnsgnl97.myqnapcloud.com:3001/api/posting');
      //텍스트필드에 2개의 값을 json을 이용하여 인코드한다음 클라이언트가 data를 보내면 서버가 data를 받고 Db에 저장된값을 보내줌
      print(response.data);
      print(response.statusCode);
      setState((){
        print("셋 스테이트");//돌아가는지 확인 하기위해 사용
        student_id= jsonEncode(response.data[0]['student_id']);//이걸써야 데이터 불러옰있음
        print(student_id);
        Title= jsonEncode(response.data[0]['title']);
        print(Title);
        LostDate=  jsonEncode(response.data[0]['lostdate']) ;
        print(LostDate);

        Time= DateTime.parse(jsonEncode(response.data[0]['lostdate'])) ;
        print(12);
        final StringTime = formatter.format(Time);
          print(Time);
          print(StringTime);
        if (response.statusCode==200) {
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
        resizeToAvoidBottomInset: true ,
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
          child:Container(
            child: Column(
              children: [
                Row(
                  children: [Text("습득물 -> 주변기기")],
                ),
                Text(Title),
                Row(
                  children: [
                    RichText(
                        text:   TextSpan(
                            style:const TextStyle(fontSize: 12, color: Colors.black) ,
                            children:<TextSpan>[
                              const TextSpan(text: '작성자 : ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: student_id),
                              //TextSpan(text:StringTime.toString()),

                            ]
                        )
                    ),
                  ],
                ),
                const Divider(
                  height: 2,
                  color: Colors.black,
                ),
                Container(
                  height: 50,
                  child:const Text("사진넣을곳임")
                ),


                Row(
                  children: [
                    RichText(
                        text:   TextSpan(
                            style:const TextStyle(fontSize: 12, color: Colors.black) ,
                            children:<TextSpan>[
                              const TextSpan(text: '분실일자 : ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: student_id),
                              //TextSpan(text:StringTime.toString()),

                            ]
                        )
                    ),
                  ],
                ),
                Row(
                  children: [
                    RichText(
                        text:   TextSpan(
                            style:const TextStyle(fontSize: 12, color: Colors.black) ,
                            children:<TextSpan>[
                              const TextSpan(text: '분실장소 : ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: student_id),
                              //TextSpan(text:StringTime.toString()),

                            ]
                        )
                    ),
                  ],
                ),
                Row(
                  children: [
                    RichText(
                        text:   TextSpan(
                            style:const TextStyle(fontSize: 12, color: Colors.black) ,
                            children:<TextSpan>[
                              const TextSpan(text: '특이사항 : ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: student_id),
                              //TextSpan(text:StringTime.toString()),

                            ]
                        )
                    ),
                  ],
                ),
              ],
            ),
          )
        ),
      )
    );


  }



}