
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lost_seoil/Write/Lostwrite.dart';

import 'package:lost_seoil/mainform/lostgetpage.dart';
import 'package:lost_seoil/headbar/mainhead.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../filter/filter.dart';
import '../Dialog/dialog.dart';
import '../menu/menu_drawer.dart';
import '../postsee/lostsee.dart';

class MyTest extends StatefulWidget{
  String name;
  int student_id;
   MyTest({Key? key,required this.student_id , required this.name}) : super(key: key);
  @override
  MyTestscreen createState()=> MyTestscreen();
}



class  MyTestscreen extends State<MyTest> {
  final _valueList = ['제목', '제목+내용', '글쓴이'];
  var _selectedValue = '제목';
  int ListSize=5;
  final List<String> entries = <String>['A', 'B', 'C','A', 'B', 'C','A', 'B', 'C','A', 'B', 'C','A', 'B', 'C','A', 'B', 'C','A', 'B', 'C','A', 'B', 'C',];
  final List<int> colorCodes = <int>[600, 500, 100,600, 500, 100,600, 500, 100,600, 500, 100,600, 500, 100,600, 500, 100,600, 500, 100,600, 500, 100];
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  void _onRefresh() async{
    print('onRefresh');
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
  void _onLoading() async{
    print('onLoading');
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    ListSize+=5;
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    entries.add((entries.length+1).toString());
    if(mounted) {
      setState(() {

      });
    }
    _refreshController.loadComplete();
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home:
        Scaffold(
          resizeToAvoidBottomInset: true , //이걸넣어 키보드가 올라왔을떄 화면이 밀리도록 설정
          appBar:const TopBar(),
          //왼쪽위 메뉴 버튼 누르면 나오는 Drawer
          drawer: MenuDrawer(name: widget.name,student_id: widget.student_id,
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
                        TextButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder:(context)=> GetPage(name: widget.name ,student_id: widget.student_id )));} ,  child: const Text('습득물',style: TextStyle(fontSize:20,color: Colors.white),),
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
                    margin: const EdgeInsets.fromLTRB(0,0, 0, 0),
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
                Container(
                  height:MediaQuery.of(context).size.width,
                   child:SmartRefresher(
                      enablePullDown: true,
                     enablePullUp: true,

                     header:  const WaterDropHeader(), //refresh 메서드를 활성화 했을 때, 물방울 표시에 로딩바가 뜬다. 다른 것도 많으니 홈페이지 참고
                    footer: CustomFooter(
                    builder: (BuildContext context,LoadStatus? mode){
                      Widget body ;
                      if(mode==LoadStatus.idle){
                        body =  const Text("pull up load");
                      }
                      else if(mode==LoadStatus.loading){
                        body =  const CupertinoActivityIndicator();
                      }
                      else if(mode == LoadStatus.failed){
                        body = const Text("Load Failed!Click retry!");
                      }
                      else if(mode == LoadStatus.canLoading){
                        body = const Text("release to load more");
                      }
                      else{
                        body = const Text("No more Data");
                      }
                      return SizedBox(
                        height: 55.0,
                        child: Center(child:body),
                      );
                    }
                  ),

                      controller: _refreshController,
                      onRefresh: _onRefresh,
                     onLoading: _onLoading,

                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),

                      itemCount: ListSize, //이거 길이만큼 리스트타일을 보여줌
                      itemBuilder: (BuildContext context, int index) {
                        return  SingleChildScrollView(
                            child:Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.amber[colorCodes[index]],
                              child: ListTile(   leading:   Image.asset('assets/images/banana.png',),//DB에 저장된 이미지 받고
                                title:  Text('배양관 413호 검은마우스'+ index.toString(), style: const TextStyle(fontSize: 15,color: Colors.black),),//DB에 저장된 타이틀 값 받고
                                subtitle: const Text("  6시간 ",style: TextStyle(color:Colors.lightBlue),),//등록일자 받고
                                onTap: () {
                                },
                              ),
                            )
                        );
                      }
                  ),
        ),
        ),




              ],

            ),


          ),
        )
    );
  }
}




