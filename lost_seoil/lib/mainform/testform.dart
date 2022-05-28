
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lost_seoil/Write/Lostwrite.dart';

import 'package:lost_seoil/mainform/lostgetpage.dart';
import 'package:lost_seoil/headbar/mainhead.dart';

import '../filter/filter.dart';
import '../Dialog/dialog.dart';
import '../menu/menu_drawer.dart';
import '../postsee/lostsee.dart';

class MyTest extends StatefulWidget{
  const MyTest({Key? key}) : super(key: key);
  @override
  MyTestscreen createState()=> MyTestscreen();
}



class  MyTestscreen extends State<MyTest> {
  final _valueList = ['제목', '제목+내용', '글쓴이'];
  var _selectedValue = '제목';
  final PageController pageController = PageController(
    initialPage: 0,
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home:
        Scaffold(
          resizeToAvoidBottomInset: true , //이걸넣어 키보드가 올라왔을떄 화면이 밀리도록 설정
          appBar:const TopBar(),
          //왼쪽위 메뉴 버튼 누르면 나오는 Drawer
          drawer: const MenuDrawer(
          ),
          //몸통시작
          body:
          SingleChildScrollView(
            child:Column(
              children:  <Widget>[

                Container(
                  padding: const EdgeInsets.all(0),margin: const EdgeInsets.all(0),
                  height: 50,width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                          fit:FlexFit.tight,
                          flex:1,
                          child:  TextButton(onPressed: (){} ,  child: const Text('분실물',style: TextStyle(fontSize:20),),
                              style: ButtonStyle(
                                // shape : 버튼의 모양을 디자인 하는 기능
                                shape: MaterialStateProperty.all <RoundedRectangleBorder>( const RoundedRectangleBorder( side : BorderSide(color:Colors.lightBlue , width: 1 ),
                                )
                                ) ,
                              )
                          )

                      ),
                      Flexible(
                        fit:FlexFit.tight,
                        flex:1,
                        child:
                        TextButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder:(context)=> const GetPage()));} ,  child: const Text('습득물',style: TextStyle(fontSize:20,color: Colors.white),),
                            style: ButtonStyle(
                              backgroundColor:   MaterialStateProperty.all(Colors.lightBlue),

                              shape: MaterialStateProperty.all <RoundedRectangleBorder>( const RoundedRectangleBorder( side : BorderSide(color:Colors.lightBlue , width: 1 ),
                              )
                              )
                              ,
                            )
                        ),
                      ),
                    ],
                  ),
                )
                ,
                Container(
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0,0, 0, 10),
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom:BorderSide (
                            width: 1,
                            color: Colors.grey,
                          )
                      ),
                    ),
                    child:Row(

                      children:   [

                        const Flexible(
                          fit:FlexFit.tight,
                          flex:3,
                          child: Text("   분실물 게시판    ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.black),)
                          ,
                        )

                        ,
                        Flexible(
                          fit:FlexFit.tight,
                          flex:1,

                          child: ElevatedButton( onPressed: () { Navigator.push(context,MaterialPageRoute(builder:(context)=>  const Lostwrite())); },
                              child: const Text("글쓰기")),

                        ),

                      ],
                    )

                )
                ,

              ],

            ),


          ),
        )
    );
  }
}




