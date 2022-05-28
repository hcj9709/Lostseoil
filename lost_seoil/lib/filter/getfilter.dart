
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';



class Getfilter extends StatefulWidget {
  const Getfilter({Key? key}) : super(key: key);
  @override
  Mygetfilter createState() => Mygetfilter();

}

class Mygetfilter extends State<Getfilter> {
  int counter = 0;
  var formatter = DateFormat("yyyy-MM-dd");
  final _valueList = ['전체', '전자기기', '카드','지갑','충전기','책'];
  var _selectedValue = '전체';

  DateTime startDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  DateTime endDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);

  Future<DateTime> _selectDate(BuildContext context,DateTime date) async {
    final DateTime? pickedDate = await showDatePicker(

      context: context,
      initialDate: date,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.lightBlue, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != date ) {
      setState(() {

        date = pickedDate;
        //  String formatDate = DateFormat('yy/MM/dd - HH:mm:ss').format(currentDate);
      });
    }
    return date;
  }//기간나오는 캘린더 다이얼로그 부분
  @override
  void dispose(){
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    return  MaterialApp(

        home:
        Scaffold(
          resizeToAvoidBottomInset: true , //이걸넣어 키보드가 올라왔을떄 화면이 밀리도록 설정
          appBar:AppBar(
            title: const Text("상세검색(습득물)"),
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
                              Text("습득물 종류",textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            ]
                        )
                    ),
                    const SizedBox(height: 10.0),
                  Container(
                  width: double.infinity,
                  height:50 ,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid
                      ),
                      borderRadius: BorderRadius.circular(0)
                  ),
                    child: DropdownButtonHideUnderline(

                        child:DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedValue,
                          items: _valueList.map(
                                (String value) {
                              return DropdownMenuItem <String>(
                                value: value,
                                child: Text( value,style: const TextStyle(fontSize: 15),),

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
                   ),

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
                          //시작기간
                          Flexible(
                            fit:FlexFit.tight,
                            flex:4,
                            child: TextButton(
                              onPressed : () async {startDate= await  _selectDate(context,startDate); },
                              child:Row(
                                  children: <Widget>[
                                    Text(formatter.format(startDate)),
                                    const Icon(Icons.calendar_month),
                                  ]
                              ),
                            ),
                          ),

                          // Text(formatter.format(startDate)),
                          // IconButton(onPressed : () async {startDate= await  _selectDate(context,startDate); } , icon: const Icon(Icons.calendar_month) ,),
                          //위에가 시작기간

                            const Flexible(
                              flex:1,
                              fit:FlexFit.tight,
                                child: Text(" ~  ",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold )),
                            ),

                          //아래가 끝 기간
                          Flexible(
                            flex:4,
                            fit:FlexFit.tight,
                            child: TextButton(
                              onPressed : () async {endDate= await _selectDate(context,endDate); },
                              child:Row(
                                  children: <Widget>[
                                    Text(formatter.format(endDate)),
                                    const Icon(Icons.calendar_month) ,
                                  ]
                              ),
                            ),
                          )
                          //끝기간
                        ]
                    ),
                    //검색박스
                    SizedBox(
                      width: 350,
                      child:TextButton(
                          onPressed: (){
                            print(_selectedValue);

                          } ,
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



