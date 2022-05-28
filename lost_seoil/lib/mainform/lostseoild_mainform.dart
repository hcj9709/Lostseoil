
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lost_seoil/Write/Lostwrite.dart';

import 'package:lost_seoil/mainform/lostgetpage.dart';
import 'package:lost_seoil/headbar/mainhead.dart';

import '../filter/filter.dart';
import '../Dialog/dialog.dart';
import '../menu/menu_drawer.dart';
import '../postsee/lostsee.dart';
class MyApp extends StatefulWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
    MyAppscreen createState()=> MyAppscreen();
}



class  MyAppscreen extends State<MyApp> {
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

                Column( //여기다가 본문 내용을 넣음

                  children:  [
                    // 게시판 글 한칸
                    ListTile(
                      leading:   ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 44,
                          maxWidth: 64,
                          maxHeight: 64,
                        ),
                        child:  Image.asset('assets/images/banana.png',fit: BoxFit.cover),
                      ),


                     //DB에 저장된 이미지 받고
                      title: const Text("배양관 413호 검은마우스", style: TextStyle(fontSize: 15,color: Colors.black),),//DB에 저장된 타이틀 값 받고

                      subtitle: const Text("  6시간",style: TextStyle(color:Colors.lightBlue),),//등록일자 받고
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder:(context)=>   Lostsee()));

                      },
                    ),
                    const Divider(
                        color: Colors.grey

                    ) ,    //여기까지가 첫줄



                    ListTile(
                      leading:   Image.asset('assets/images/banana.png',),//DB에 저장된 이미지 받고
                      title: const Text("배양관 413호 검은마우스", style: TextStyle(fontSize: 15,color: Colors.black),),//DB에 저장된 타이틀 값 받고

                      subtitle: const Text("  6시간",style: TextStyle(color:Colors.lightBlue),),//등록일자 받고
                      onTap: () {},
                    ),
                    const Divider(
                        color: Colors.grey

                    ) ,
                    ListTile(
                      leading:   Image.asset('assets/images/banana.png',),//DB에 저장된 이미지 받고
                      title: const Text("배양관 413호 검은마우스", style: TextStyle(fontSize: 15,color: Colors.black),),//DB에 저장된 타이틀 값 받고

                      subtitle: const Text("  6시간",style: TextStyle(color:Colors.lightBlue),),//등록일자 받고
                      onTap: () {},
                    ),
                    const Divider(
                        color: Colors.grey

                    ) ,
                    ListTile(
                      leading:   Image.asset('assets/images/banana.png',),//DB에 저장된 이미지 받고
                      title: const Text("배양관 413호 검은마우스", style: TextStyle(fontSize: 15,color: Colors.black),),//DB에 저장된 타이틀 값 받고

                      subtitle: const Text("  6시간",style: TextStyle(color:Colors.lightBlue),),//등록일자 받고
                      onTap: () {},
                    ),
                    const Divider(
                        color: Colors.grey

                    ) ,
                    ListTile(
                      leading:   Image.asset('assets/images/banana.png',),//DB에 저장된 이미지 받고
                      title: const Text("배양관 413호 검은마우스", style: TextStyle(fontSize: 15,color: Colors.black),),//DB에 저장된 타이틀 값 받고

                      subtitle: const Text("  6시간",style: TextStyle(color:Colors.lightBlue),),//등록일자 받고
                      onTap: () {},
                    ),
                    const Divider(
                        color: Colors.grey
                    ) ,
                    ListTile(
                      leading:   Image.asset('assets/images/banana.png',),//DB에 저장된 이미지 받고
                      title: const Text("배양관 413호 검은마우스", style: TextStyle(fontSize: 15,color: Colors.black),),//DB에 저장된 타이틀 값 받고

                      subtitle: const Text("  6시간",style: TextStyle(color:Colors.lightBlue),),//등록일자 받고
                      onTap: () {},
                    ),
                    const Divider(
                        color: Colors.grey
                    ) ,
                  ],
                )
          ,
                Column(
                  //이거는 필터쪽
                  children: [
                    //Text("필터 필드")
                  Align(
                    alignment: Alignment.topRight,
                   child: TextButton.icon(onPressed: (){Navigator.push(context,MaterialPageRoute(builder:(context)=>  const Myfilter()));}, icon:  const Icon(Icons.tune,), label: const Text("필터"),)
                  )
                  ],


                )
                ,


                 Container(
                   width: double.infinity,
                   height:50 ,
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   decoration: BoxDecoration(
                       border: Border.all(
                           color: Colors.lightBlue,
                           width: 1,
                           style: BorderStyle.solid
                       ),
                       borderRadius: BorderRadius.circular(0)
                   ),
                child:SizedBox( //검색하는 쪽 넣을 필드
                    width: double.infinity,
                  child: Row(
                  children:
                  [
                    Flexible(
                      fit:FlexFit.tight,
                      flex: 2,
                      child: DropdownButtonHideUnderline(

                          child:DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedValue,
                            items: _valueList.map(
                                  (String value) {
                                return DropdownMenuItem <String>(
                                  value: value,
                                  child: Text( value,style: const TextStyle(fontSize: 13),),

                                );
                              },
                            ).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedValue =  value!;
                              });
                            },


                          )

                      ),
                    )
                            ,
                     const Flexible(
                      fit:FlexFit.tight,
                      flex: 7,
                     child: TextField(

                         decoration: InputDecoration(
                           border: InputBorder.none,
                           focusedBorder: InputBorder.none,
                           fillColor: Colors.white,
                           filled: true, labelText: '찾으실 물건 입력',
                      )
                     ),
                    )
                    ,
                    Flexible(
                        fit:FlexFit.loose,
                        flex: 1,

                        child: IconButton(icon: const Icon(Icons.search,color: Colors.lightBlue,size: 30,), onPressed: (){})

                    )
                  ],
                ),
                )
        ),
      ],

            ),


          ),

          bottomNavigationBar:const BottomAppBar(),
        )
    );
  }
}




