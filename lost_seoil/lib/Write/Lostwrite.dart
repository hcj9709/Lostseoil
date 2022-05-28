
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Lostwrite extends StatefulWidget {
  const Lostwrite({Key? key}) : super(key: key);
  @override
  MyLostwrite createState() => MyLostwrite();

}

class MyLostwrite extends State<Lostwrite> {
    File? imageFile  = File(''); // 카메라/갤러리에서 사진 가져올 때 사용함 (image_picker)
  final ImagePicker _picker = ImagePicker(); // 카메라/갤러리에서 사진 가져올 때 사용함 (image_picker)
  late String filtertext;
    final _valueList = ['전체', '전자기기', '카드','지갑','충전기','책','기타'];
    var _selectedValue = '전체';
    final TitleController = TextEditingController();
    final LostwhereController = TextEditingController();
    final Content = TextEditingController();
    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      TitleController.dispose();
      LostwhereController.dispose();
      Content.dispose();

    }
  Widget bottomSheet() {
    return SingleChildScrollView(
      child: Container(
        height: 130,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 25
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              '사용할 기능을 선택해주세요',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton.icon(
                  icon: const Icon(Icons.camera, size: 50,),
                  onPressed: () {
                    takePhoto(ImageSource.camera);

                  },
                  label: const Text('카메라', style: TextStyle(fontSize: 15),),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.photo_library, size: 50,),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  label: const Text('갤러리', style: TextStyle(fontSize: 15),),
                )
              ],
            )
          ],
        )
    )
    );
  }

  Future <File?> takePhoto(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if(pickedFile==null){return null;}
    setState(() {
      imageFile = File(pickedFile.path)    ;
    });

  }
  /*
  Future getImageCamera() async {

    // for camera
    final pickedFile = await _picker.pickImage(source: ImageSource.camera, maxWidth: 480, maxHeight: 600);
    setState(() {
      imageFile = pickedFile as PickedFile?;
    });
  }
  */

  TextEditingController dateinput = TextEditingController();


   TextEditingController writeinput = TextEditingController( text: "분실장소 : \n\n"
       "특이사항 : \n\n"
       "분실물 : \n"
     ,); //글자 컨트롤러

  //text editing controller for text field
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    imageFile=null ; // 파일 초기값을 null로 설정
    super.initState();
  }

  int counter = 0;
  var formatter = DateFormat("yyyy-MM-dd");


  DateTime LostDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);

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
    if (pickedDate != null  ) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {

        date = pickedDate;
        dateinput.text = formattedDate;
        //  String formatDate = DateFormat('yy/MM/dd - HH:mm:ss').format(currentDate);
      });

    }
    return date;
  }//기간나오는 캘린더 다이얼로그 부분




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(
        resizeToAvoidBottomInset: true , //이걸넣어 키보드가 올라왔을떄 화면이 밀리도록 설정
        appBar:AppBar(
          title: const Text("분실물 게시판 글쓰기"),
          leading:  IconButton(
            icon: const Icon(Icons.arrow_back_ios),color:Colors.white, onPressed: () {
            Navigator.pop(context);
          },) //글쓰기에서 뒤로가기 버튼인데 이거 나중에 보완하는것이 좋을거같음
          ,
        )
        //왼쪽위 메뉴 버튼 누르면 나오는 Drawer
        ,
        body:SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(0.5),
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,

                ),
              ),
            child:Column(
              children:  [
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 3, 5,0),
                  padding: const EdgeInsets.fromLTRB(5,0, 5, 0),
                child:Align(
                  alignment:Alignment.topLeft ,
                  child:   RichText(
                      text:   const TextSpan(
                          style:TextStyle(fontSize: 16, color: Colors.black) ,
                          children:<TextSpan>[
                            TextSpan(text: ' 제목 ', style: TextStyle(fontWeight: FontWeight.bold)),
                          ]
                      )
                  ),
                ),
                    ),
                Container(

                  margin: const EdgeInsets.fromLTRB(5, 3, 5,0),
                  padding: const EdgeInsets.fromLTRB(5,10, 5, 0),
                  child:  TextField(
                      controller: TitleController,
                      decoration: InputDecoration(
                        border : OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        fillColor: Colors.white,
                        filled: true, labelText: '제목을 입력해주세요',
                      )
                  ),
                ),//여기까지 제목칸

                Container(
                  margin: const EdgeInsets.fromLTRB(5, 3, 5,10),
                  padding: const EdgeInsets.fromLTRB(5,10, 5, 0),
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex:1,

                            child: RichText(
                              text:  const TextSpan(
                                  style:TextStyle(fontSize: 16, color: Colors.black) ,
                                  children:<TextSpan>[
                                    TextSpan(text: '분류       ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ]
                              )
                          ),
                          ),
                           Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child:Container(
                                height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      border: Border.all(color: Colors.lightBlue)
                                  ),
                              child:DropdownButtonHideUnderline(
                               child: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedValue,

                                items: _valueList.map(

                                      (String value) {
                                    return DropdownMenuItem <String>(
                                      value: value,
                                      child: Text( value,style: const TextStyle(fontSize: 15),
                                        textAlign: TextAlign.center,
                                      ),

                                    );
                                  },
                                ).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedValue =  value!;
                                  });

                                },


                              )
                              )
                              ,

                              )
                          ),
                        ],//첫번쨰 로우끝
                      ),
                      const SizedBox(
                        height: 10,
                      )
                      ,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Flexible(
                            flex:1,
                            child:RichText(
                                text:  const TextSpan(
                                    style:TextStyle(fontSize: 16, color: Colors.black) ,
                                    children:<TextSpan>[
                                      TextSpan(text: '분실날짜  ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ]
                                )
                            ),
                          ),

                          Flexible(
                            flex:3,
                           fit: FlexFit.tight,
                           child:Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(0),
                                 border: Border.all(color: Colors.lightBlue)
                             ),
                             height: 40,
                           child:TextButton(

                            onPressed : () async {LostDate= await _selectDate(context,LostDate); },
                            child:Row(
                                children: <Widget>[
                                  Text(formatter.format(LostDate),textAlign: TextAlign.center,),
                                  const Icon(Icons.calendar_month) ,
                                ]
                            ),
                          ),
                          )
                          )
                        ],
                      )
                      ,
                    ],


                  )
                )
                ,

                Container(
                    margin: const EdgeInsets.fromLTRB(5, 3, 5,10),
                    padding: const EdgeInsets.fromLTRB(5,0, 5, 0),

                        child:Column(
                         children: [
                            Align(
                               alignment:Alignment.topLeft,
                              child: RichText(
                               text:  const TextSpan(
                                   style:TextStyle(fontSize: 16, color: Colors.black) ,
                                   children:<TextSpan>[
                                     TextSpan(text: '분실장소  ', style: TextStyle(fontWeight: FontWeight.bold)),
                                   ]
                               )
                           ),
                            ),
                           const SizedBox(
                             height: 17,
                           ),
                             SizedBox(
                               height: 40,
                              child:TextField(
                                  controller: LostwhereController,
                               decoration: InputDecoration(
                                 border : OutlineInputBorder(
                                   borderSide: const BorderSide(width: 1, color: Colors.grey),
                                   borderRadius: BorderRadius.circular(0),
                                 ),
                                 focusedBorder: OutlineInputBorder(
                                   borderSide: const BorderSide(width: 1, color: Colors.grey),
                                   borderRadius: BorderRadius.circular(0),
                                 ),
                                 fillColor: Colors.white,
                                 filled: true,
                                 labelText: '분실장소를 입력해주세요',
                               )
                                    ,style:const TextStyle(fontSize: 13)
                           ),
                )
                              ],
                        )
                ),

                            const Divider(
                          color: Colors.grey

                             ) ,
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                margin:const EdgeInsets.fromLTRB(5, 0, 5, 3),

                         child: Column(
                             children : [
                           Align(
                                    alignment: Alignment.topCenter,
                           child : imageFile != null
                              ? Image.file(
                             File(imageFile!.path),
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.fitHeight,
                             )
                            :  const Text("밑에 갤러리 버튼을 눌러 사진을 추가 하실 수 있습니다.",style: TextStyle(color: Colors.grey,fontSize: 10),

                           )
                           )


                      ,

                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       mainAxisSize: MainAxisSize.min,
                                     children: [
                                      IconButton(icon: const Icon(Icons.photo_album_rounded), onPressed: () {
                                showModalBottomSheet(context: context, builder: ((builder) => bottomSheet()));

                              }),
                        ],
                      )
                      ,
                            const Divider(
                          color: Colors.grey

                      ) ,
                            Container(
                              margin: const EdgeInsets.fromLTRB(5, 3, 5,10),
                                padding: const EdgeInsets.fromLTRB(5,10, 5, 0),
                                child:Column(
                                    children: [
                                      Align(
                                        alignment:Alignment.topLeft ,
                                       child:   RichText(
                                         text:   const TextSpan(
                                        style:TextStyle(fontSize: 16, color: Colors.black) ,
                                        children:<TextSpan>[
                                          TextSpan(text: ' 특이사항 ', style: TextStyle(fontWeight: FontWeight.bold)),
                                        ]
                                    )
                                ),
                                      ),
                                          const SizedBox(
                                            height: 17,
                                          ),
                                           TextField(
                                             controller: Content,
                                             minLines: 4,
                                             keyboardType: TextInputType.multiline,
                                             maxLines: null,
                                           decoration: InputDecoration(
                                             border : OutlineInputBorder(
                                               borderSide: const BorderSide(width: 1, color: Colors.grey),
                                               borderRadius: BorderRadius.circular(0),
                                             ),
                                             focusedBorder: OutlineInputBorder(
                                               borderSide: const BorderSide(width: 1, color: Colors.grey),
                                               borderRadius: BorderRadius.circular(0),
                                             ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelText: '특이사항을 입력해주세요',
                                      ),
                                            style:const TextStyle(fontSize: 13),
                                  )
                              ,
                            ],

                          )
                      ),
                    ]
                  ),
                       ),

                Container(
                width:  double.infinity,
                  padding: const EdgeInsets.fromLTRB(0,0, 0, 0),

                  height: 60,
                 child:TextButton(
                    onPressed: (){
                      print(_selectedValue);
                      print(LostDate);
                      print(TitleController.text);
                      print(LostwhereController.text);
                      print(Content.text);
                      print(imageFile);
                    },
                    child:const Text("등록",style:  TextStyle(fontSize:20,color: Colors.white),),
                    style: ButtonStyle(
                      backgroundColor:   MaterialStateProperty.all(Colors.lightBlue),
                      // shape : 버튼의 모양을 디자인 하는 기능
                      shape: MaterialStateProperty.all <RoundedRectangleBorder>( const RoundedRectangleBorder( side : BorderSide(color:Colors.lightBlue , width: 1 ),
                      )
                      ) ,
                    )
                ),
                       )

                    ],

            )

          ),

        ) ,

      )
    );

  }


}

