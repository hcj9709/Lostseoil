import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lost_seoil/share/lostseoild_mainform.dart';

import 'Switch_login.dart';

// ignore: camel_case_types
class Login_page extends StatelessWidget {
  const Login_page({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(

      home: Scaffold(

        resizeToAvoidBottomInset: false , //바닥이 오버 플로우 일어나지 않도록 하기위해

        body: SingleChildScrollView(
        child:Container(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 120),
          alignment: Alignment.bottomLeft,
          child: Column(
            children:  [
               Align(
                alignment: Alignment.centerLeft,
                  child:Row(
                    children:const [
                       Text("LOST",textAlign: TextAlign.left,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                       Text(" 서일",textAlign: TextAlign.left,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.lightBlue),),

            ]
                  )
              ),
              const SizedBox(height: 12.0),
            const TextField(decoration: InputDecoration( filled: true, labelText: '아이디',
              fillColor: Colors.white,
            )),
              const SizedBox(height: 12.0),
          const TextField(decoration: InputDecoration( filled: true, labelText: '비밀번호',
            fillColor: Colors.white,
          )),
              const SwitchLog(),
              const SizedBox(height: 10.0),


              SizedBox(
                width: 350,
              child:TextButton(
                  onPressed: (){} ,
                  child: const Text('로그인',style: TextStyle(fontSize:20,color: Colors.white),),
                  style: ButtonStyle(
                    backgroundColor:   MaterialStateProperty.all(Colors.lightBlue),

                    // shape : 버튼의 모양을 디자인 하는 기능
                    shape: MaterialStateProperty.all <RoundedRectangleBorder>( const RoundedRectangleBorder( side : BorderSide(color:Colors.lightBlue , width: 1 ),
                    )
                    ) ,
                  )
              ),
                 ),

              GestureDetector(

                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("아이디/비밀번호 찾기",textAlign: TextAlign.left,style: TextStyle(fontSize: 11,),),
                  ),
                onTap: (){},

              ),

            ], //위젯끝
          )

        ),
      )
      )
      ,
    );
  }

}