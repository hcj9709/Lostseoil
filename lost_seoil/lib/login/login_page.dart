import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lost_seoil/share/lostseoild_mainform.dart';
import 'package:http/http.dart' as http;
import '../Dialog/loginfail.dart';
import '../share/Switch_login.dart';

// ignore: camel_case_types
class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);
  @override
  StateLogin_page createState() => StateLogin_page();
}





class StateLogin_page extends State<Login_page> {
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  late bool islogined ;


  @override
   initState()   {
    super.initState();
    islogined=false;
    //WidgetsBinding.instance.addPostFrameCallback((_) {servarMethod();});
  }
  @override
  void dispose() {
    // TODO: implement dispose
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> getHttp()  async {
      Dio dio = Dio();
    try {
      final response = await dio.get('http://wnsgnl97.myqnapcloud.com:3001/api/user/login',
          queryParameters: {'id':idController.text , 'password':passwordController.text});
      //텍스트필드에 2개의 값을 쿼리파라미터로 값을 서버에 전달하여 서버에 인증을 성공한후 데이터를 받음

      print(response.data);

      setState((){
        islogined= response.data['success']; //이렇게 해야 db에 저장되어있는 "석세스" 라는 값을 받을수있음
      });

    } catch (e) {
      print(e);
    }
    finally{
      if (islogined==true) {
        Navigator.push(context,MaterialPageRoute(builder:(context)=>  const MyApp()));
        print("로그인성공");
      }
      else{
        Future.delayed(Duration.zero, () => LoginfailDialog(context));
        print("로그인실패");
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(

      home: Scaffold(

          resizeToAvoidBottomInset: true , //바닥이 오버 플로우 일어나지 않도록 하기위해

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
                              Text("LOST IN",textAlign: TextAlign.left,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                              Text(" 서일",textAlign: TextAlign.left,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.lightBlue),),

                            ]
                        )
                    ),
                    const SizedBox(height: 12.0),
                     TextField(
                      controller: idController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration( filled: true, labelText: '학번',
                      fillColor: Colors.white,
                    )
                      ,onChanged:(text){
                        print(idController.text);
                     }
                      ,
                    ),
                    const SizedBox(height: 12.0),
                     TextField(
                      controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration( filled: true, labelText: '비밀번호',
                          fillColor: Colors.white,
                        )
                         ,
                         onChanged:(text){
                           print(passwordController.text);
                           }
                     ),
                    const SwitchLog(),
                    const SizedBox(height: 10.0),


                    SizedBox(
                      width: 350,
                      child:TextButton(
                          onPressed: ()  {
                            print(idController.text);
                            print(passwordController.text);

                           WidgetsBinding.instance!.addPostFrameCallback((_)  { getHttp();});



                          } ,
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
                        child: Text("학번/비밀번호 찾기",textAlign: TextAlign.left,style: TextStyle(fontSize: 11,),),
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

