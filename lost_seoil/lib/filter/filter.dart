import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../Dialog/dialog.dart';
import '../Dialog/timesetdialog.dart';
import '../dropdown/dropdownbutton.dart';
import '../dropdown/filterlistdropdown.dart';


class Myfilter extends StatefulWidget {
  const Myfilter({Key? key}) : super(key: key);
  @override
  Mygetfilter createState() => Mygetfilter();

}

class Mygetfilter extends State<Myfilter> {

  DateTime currentDate = DateTime.now();
  String formatDate = DateFormat('yy/MM/dd').format(DateTime.now());


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(

        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));

    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
       String formatDate = DateFormat('yy/MM/dd - HH:mm:ss').format(currentDate);

      });

    }
  }//기간나오는 캘린더 다이얼로그 부분

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      
        home:
        Scaffold(
          resizeToAvoidBottomInset: true , //이걸넣어 키보드가 올라왔을떄 화면이 밀리도록 설정
          appBar:AppBar(
            title: const Text("상세검색"),
            leading:  IconButton(
              icon: const Icon(Icons.arrow_back_ios),color:Colors.white, onPressed: () {
              Navigator.pop(context);
            },)
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
                    const Filterdropdown(),


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
                    //기간에 대한 타임 테이블이 나와야함
                    Row(
                      children:<Widget> [
                        Text(formatDate),
                        IconButton(onPressed : () =>  _selectDate(context) , icon: const Icon(Icons.calendar_month) ,),
                        //위에가 시작기간
                        //아래가 끝 기간
                        Text(formatDate),
                        IconButton(onPressed : () =>  _selectDate(context) , icon: const Icon(Icons.calendar_month) ,),
                      ]
                    ),
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



                  ], //위젯끝
                )

            ),
          ),
          bottomNavigationBar:const BottomAppBar(),
        )
    );
  }



}



