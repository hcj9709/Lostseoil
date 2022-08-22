import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../postsee/lostsee.dart';

class Search extends StatefulWidget {
  String name;
  int student_id;
  String searchText;
  String startDate;
  String endDate;
  String selectedValue;
  Search({Key? key,required this.name,required this.student_id
    ,required this.searchText ,required this.startDate
    ,required this.endDate ,required this.selectedValue}) : super(key: key);
  @override
  Searchstart createState() => Searchstart();
}





class Searchstart extends State<Search> {
  int ListSize=0;
  final List<String> writeDate=<String>[];
  final List<String> Title=<String>[];
  final List<int> is_complete =<int>[];
  final List<int> LostIndex = <int>[];
  final List<String> imagefile =<String>[] ;
  @override
  void initState(){
    super.initState();
    MyPosting();
  }
  Future <void> MyPosting()async {
    try {
      Dio dio = Dio();
      Response response = await dio.get('http://wnsgnl97.myqnapcloud.com:3001/api/posting/',
          queryParameters: {
            'title_content':widget.searchText,
            'startDate':widget.startDate,
            'endDate':widget.endDate,
            'category':widget.selectedValue
          }
      );
      setState((){
        print("셋 스테이트");//돌아가는지 확인 하기위해 사용
        if (response.statusCode==200) {
          for(int i = response.data.length-1 ; i>=0; i--){

            Title.add(response.data[i]['title']);//<<여기서 오류

            writeDate.add(response.data[i]['time']);
            ListSize++;
            is_complete.add(response.data[i]['is_complete']);
            LostIndex.add(response.data[i]['id']);
            if(response.data[i]['image']!=null){
              imagefile.add(response.data[i]['image']);
            }else{imagefile[i]="null"; }

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
  Widget build(BuildContext context) {
    return MaterialApp(
        home:Scaffold(
            appBar: AppBar(
                title: Text("검색"),
                leading:  IconButton(
                  icon: const Icon(Icons.arrow_back_ios),color:Colors.white, onPressed: () {
                  Navigator.pop(context);
                },)
            ),
            body:SingleChildScrollView(
              child:Container(
                child:Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        itemCount: ListSize, //이거 길이만큼 리스트타일을 보여줌
                        itemBuilder: (BuildContext context, int index) {
                          return  SingleChildScrollView(
                              child:Container(
                                width: MediaQuery.of(context).size.width,
                                child:Column(
                                    children:[
                                      ListTile(
                                        leading:  Column(
                                          children: [
                                            if( imagefile[index]!="null"  )...[
                                              Container(
                                                margin: EdgeInsets.all(0),
                                                width:55,
                                                height:56,
                                                child : ClipRRect(
                                                    borderRadius: BorderRadius.circular(3.0),
                                                    child: Image.network(imagefile[index],fit: BoxFit.cover,) // Text(key['title']),
                                                ),

                                              ),
                                            ]
                                            else...[
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 15),
                                                  child:Text("사진없당")
                                              ),
                                            ],
                                          ],
                                        )
                                        ,//

                                        title:  Text(Title[index], style: const TextStyle(fontSize: 15,color: Colors.black),),//DB에 저장된 타이틀 값 받고
                                        subtitle:  Text(writeDate[index],style: const TextStyle(color:Colors.lightBlue),),//등록일자 받고
                                        onTap: () {
                                          Navigator.push(context,MaterialPageRoute(builder:(context)=>   Lostsee(LostIndex:LostIndex[index],student_id: widget.student_id, name: widget.name,)));
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
                  ],
                ),
              ),
            )
        )
    );
  }
}