
import 'package:dio/dio.dart';
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
class MyApp extends StatefulWidget{
  String name;
  int student_id;

   MyApp({Key? key,required this.student_id , required this.name}) : super(key: key);


  @override
    MyAppscreen createState()=> MyAppscreen();
}



class  MyAppscreen extends State<MyApp> {
  final _valueList = ['제목', '제목+내용', '글쓴이'];
  var _selectedValue = '제목';
  late int listindex;
  int ListSize=0;
  String? imagefile ;

  final List<String> writeDate=<String>[];
  final List<String> Title=<String>[];
  final List<String> entries = <String>[];
  final List<int> colorCodes = <int>[];
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  List<int> LostIndex = <int>[];

  Future <void> LostPosting()async {
    try {
      Dio dio = Dio();
      listindex=0;
      print("check");
      Response response = await dio.get('http://wnsgnl97.myqnapcloud.com:3001/api/posting',
          queryParameters: {
            'title_content':'',
            'startDate':'',
            'endDate':'',
            'category':''
          }
      );

      setState((){
        print("셋 스테이트");//돌아가는지 확인 하기위해 사용

        if (response.statusCode==200) {
          for(int i = response.data.length-1; i>=0;i--){
            if(response.data[i]['losttype']==1){ //losttype 1로잡아서 분실물만 보여주도록함
              entries.add(response.data[i]['name']);
              print(entries);
              Title.add( response.data[i]['title']);
              print(Title);
              writeDate.add(response.data[i]['time']);
              LostIndex.add(response.data[i]['id']);
              print(LostIndex);
              imagefile = response.data[i]['image'];
              listindex++;
            }
          }

        }

      });

    } catch (e) {
      print("서버에러");
    }
    finally{

    }

  }
  @override
  void initState(){
    super.initState();
    LostPosting();
    ListSize=5;
  }
  void _onRefresh() async{
    print('onRefresh');

    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    _refreshController.refreshCompleted();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => super.widget));


  }

  void _onLoading() async{
    print('onLoading');
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    if(entries.length-5>ListSize)
    {ListSize+=5;}
    else{//10+(13-10)
      ListSize = ListSize+(entries.length-ListSize);
    }
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // entries.add((entries.length+1).toString());
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
          appBar:AppBar(
              backgroundColor:Colors.white ,

              iconTheme: const IconThemeData(

                color: Colors.lightBlue ,//색변경
                size: 37,

              ),

              title: RichText(
                  text:  const TextSpan(
                      style:TextStyle(fontSize: 27, color: Colors.lightBlue) ,
                      children:<TextSpan>[
                        TextSpan(text: "LOST", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                        TextSpan(text: " IN", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                        TextSpan(text: " 서일", style: TextStyle(fontWeight: FontWeight.bold)),
                      ]
                  )
              ),
              //타이틀

              actions: <Widget>[
                const MyPopUp()  , // 다이얼로그 팝업 열리는 함수임
                IconButton(
                  visualDensity: const VisualDensity(horizontal: -4.0, vertical: -2.0), //이부분이 줄여주는 부분이다.
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.search,size: 30 ,),color:Colors.lightBlue, onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder:(context)=>  Myfilter(name: widget.name, student_id: widget.student_id,)));
                },),

              ]

          ),

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

                          child: ElevatedButton( onPressed: () { Navigator.push(context,MaterialPageRoute(builder:(context)=>   Lostwrite(name: widget.name,student_id: widget.student_id))); },
                              child: const Text("글쓰기")),

                        ),

                      ],
                    )

                )
                ,FutureBuilder(
                    future: _fetch1(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                      if (snapshot.hasData == false) {
                        return CircularProgressIndicator();
                      }
                      //error가 발생하게 될 경우 반환하게 되는 부분
                      else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }
                      // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                      else {
                        return Container(
                          height:MediaQuery.of(context).size.width,
                          child:SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,

                            header:  const WaterDropHeader(), //refresh 메서드를 활성화 했을 때, 물방울 표시에 로딩바가 뜬다. 다른 것도 많으니 홈페이지 참고
                            footer: CustomFooter(
                                builder: (BuildContext context,LoadStatus? mode){
                                  Widget body ;
                                  if(mode==LoadStatus.idle){
                                    body =  const Text("끝");
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

                                        width: MediaQuery.of(context).size.width,
                                        child:Column(
                                            children:[
                                              ListTile(   leading:   Image.asset('assets/images/banana.png',),//DB에 저장된 이미지 받고
                                                title:  Text(Title[index]+ index.toString(), style: const TextStyle(fontSize: 15,color: Colors.black),),//DB에 저장된 타이틀 값 받고
                                                subtitle:  Text(writeDate[index],style: const TextStyle(color:Colors.lightBlue),),//등록일자 받고
                                                onTap: () {

                                                  Navigator.push(context,MaterialPageRoute(builder:(context)=>   Lostsee(LostIndex:LostIndex[index],student_id: widget.student_id)));
                                                },
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
                          ),
                        );//컨테이너 끝
                      }
                    }),





              ],

            ),


          ),
        )
    );
  }
  Future<String> _fetch1() async {
    await Future.delayed(const Duration(seconds:1));
    return 'Call Data';
  }
}