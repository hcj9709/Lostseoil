  import 'package:flutter/material.dart';

import '../login/login_page.dart';

// ignore: non_constant_identifier_names
Future<void>  LogoutDialog(BuildContext context) async {
      await showDialog(
        context: context ,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,

        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(15), //다이얼로그 박스에 대한 패딩
            titlePadding: const EdgeInsets.all(0), //타이틀에대한 패딩
            //contentPadding: const EdgeInsets.all(8), //글 내용에 대한 패딩
            contentPadding: const EdgeInsets.only(top: 0, left: 8,right: 8, bottom: 0),
            actionsPadding:const EdgeInsets.all(0) ,//action거기에 대한 패딩

            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0)),
            //Dialog Main Title

            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children:  const <Widget>[
                SizedBox(

                    child: Align(

                        alignment: Alignment.topRight,
                        child:Text(""
                        )
                    )
                ),
              ],

            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Text("접속중인 기기에서 로그아웃 하시겠습니까?"
                  ,style: TextStyle(fontSize:14,fontWeight:FontWeight.bold,height: 1.7,), textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              TextButton(
                child: const Text("확인"),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                  Navigator.push(context,MaterialPageRoute(builder:(context)=>  const Login_page()));
                },

              ),
                   TextButton(
                         child: const Text("취소"),
                         onPressed: () {
                           Navigator.pop(context);
                             },
                   ),
            ],
          );
        });
  }



