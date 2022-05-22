
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lost_seoil/dropdown/lostdropdown.dart';

class Lostwrite extends StatefulWidget {
  const Lostwrite({Key? key}) : super(key: key);
  @override
  MyLostwrite createState() => MyLostwrite();

}

class MyLostwrite extends State<Lostwrite> {
    File? imageFile  = File(''); // 카메라/갤러리에서 사진 가져올 때 사용함 (image_picker)
  final ImagePicker _picker = ImagePicker(); // 카메라/갤러리에서 사진 가져올 때 사용함 (image_picker)


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
  void dispose(){
    super.dispose();
  }



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
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
            child:Column(
              children:  [

                  const Lostdropdown(),

                Container(
                  child: const TextField(
                      decoration: InputDecoration(
                     border : OutlineInputBorder(),
                     focusedBorder: OutlineInputBorder(),
                     fillColor: Colors.white,
                     filled: true, labelText: '제목을 입력해주세요',
                   )
                ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 0, 3),
                  child: Row(
                    children:[
                    RichText(
                        text:  const TextSpan(
                            style:TextStyle(fontSize: 16, color: Colors.black) ,
                            children:<TextSpan>[
                              TextSpan(text: '분실날짜 : ', style: TextStyle(fontWeight: FontWeight.bold)),
                            ]
                        )
                    ),
                   TextButton(
                    onPressed : () async {LostDate= await _selectDate(context,LostDate); },
                    child:Row(
                      children: <Widget>[
                        Text(formatter.format(LostDate)),
                        const Icon(Icons.calendar_month) ,
                      ]
                  ),
                ),
                  ]
                    ),
                )    ,


                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  margin:const EdgeInsets.fromLTRB(5, 0, 0, 3),
                  child:Column(

                    children:[
                      Container(
                        child:Row(
                         children: [
                           Flexible(
                             fit:FlexFit.tight,
                             flex:1,
                            child : RichText(
                               text:  const TextSpan(
                                   style:TextStyle(fontSize: 16, color: Colors.black) ,
                                   children:<TextSpan>[
                                     TextSpan(text: '분실장소 : ', style: TextStyle(fontWeight: FontWeight.bold)),
                                   ]
                               )
                           ),
                                 )
                           , const Flexible(
                             fit:FlexFit.tight,
                             flex:3,
                            child: TextField(
                               decoration: InputDecoration(
                                 border : InputBorder.none,

                                 focusedBorder: InputBorder.none,
                                 fillColor: Colors.white,
                                 filled: true,
                                 labelText: '분실장소를 입력해주세요',
                               )
                           )
                           ),
                        ],

                        )
                      ),




                        Column(
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
                         ]
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
                      Container(
                          child:Row(
                            children: [
                              Flexible(
                                fit:FlexFit.tight,
                                flex:1,
                                child : RichText(
                                    text:  const TextSpan(
                                        style:TextStyle(fontSize: 16, color: Colors.black) ,
                                        children:<TextSpan>[
                                          TextSpan(text: '특이사항 : ', style: TextStyle(fontWeight: FontWeight.bold)),
                                        ]
                                    )
                                ),
                              )
                              , const Flexible(
                                  fit:FlexFit.tight,
                                  flex:3,
                                  child: TextField(
                                      decoration: InputDecoration(
                                        border : InputBorder.none,

                                        focusedBorder: InputBorder.none,
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelText: '특이사항을 입력해주세요',
                                      )
                                  )
                              ),
                            ],

                          )
                      ),
                    ]
                  ),
                       ),

                Container(
                width:  double.infinity
                ,
                    height: 60,
                child:TextButton(
                    onPressed: (){},
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

