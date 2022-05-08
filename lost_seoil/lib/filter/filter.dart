import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../share/dropdownbutton.dart';

class Mygetfilter extends StatelessWidget {

  const Mygetfilter({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
        home:
        Scaffold(
          resizeToAvoidBottomInset: true , //이걸넣어 키보드가 올라왔을떄 화면이 밀리도록 설정
          appBar:AppBar(
            title: const Text("상세검색"),
            leading: const Icon(Icons.arrow_back_ios)
            ,
          )
          //왼쪽위 메뉴 버튼 누르면 나오는 Drawer
          ,
          //몸통시작
          body:   SingleChildScrollView(
            child:Container(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 120),
                alignment: Alignment.bottomLeft,
                child: Column(
                  children:  [
                    Align(
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children:const [
                              Text("제목명",textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            ]
                        )
                    ),
                    const SizedBox(height: 3.0),
                    const TextField(decoration: InputDecoration( filled: true, labelText: '찾으실 제목을 입력해주세요',
                      fillColor: Colors.white,
                    )),
                    const SizedBox(height: 12.0),
                    Align(
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children:const [
                              Text("분실물 종류",textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            ]
                        )
                    ),
                    const Mydropdown(),


                    const SizedBox(height: 10.0),
                    const SizedBox(height: 12.0),
                    Align(
                        alignment: Alignment.centerLeft,
                        child:Row(
                            children:const [
                              Text("기간",textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            ]
                        )
                    ),
                    const Mydropdown(),

                    SizedBox(
                      width: 350,
                      child:TextButton(
                          onPressed: (){} ,
                          child: const Text('검색',style: TextStyle(fontSize:20,color: Colors.white),),
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
          ),
          bottomNavigationBar:const BottomAppBar(),
        )
    );
  }
}
