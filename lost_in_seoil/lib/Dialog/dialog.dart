import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
const keyIsFirstLoaded = null;
class MyPopUp extends StatelessWidget {
  const MyPopUp({Key? key}) : super(key: key);
  // Wrapper Widget

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration.zero, () => FlutterDialog(context));
    return const Text("");
  }


// ignore: non_constant_identifier_names
Future<void> FlutterDialog(BuildContext context) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
  if (isFirstLoaded == null) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: true,

        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(15),
            //다이얼로그 박스에 대한 패딩
            titlePadding: const EdgeInsets.all(0),
            //타이틀에대한 패딩
            //contentPadding: const EdgeInsets.all(8), //글 내용에 대한 패딩
            contentPadding: const EdgeInsets.only(
                top: 0, left: 8, right: 8, bottom: 0),
            actionsPadding: const EdgeInsets.all(0),
            //action거기에 대한 패딩

            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0)),
            //Dialog Main Title

            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                      height: 30,
                    child: Align(

                        alignment: Alignment.topRight,
                        child:Text("")
                    )
                ),
              ],

            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Text(
                  "분실물을 고의로 가져가신경우 대한민국 형법 360조(점유물이탈횡령죄)의거 1년이하 징역 또는 300만원 이하 벌금에 처합니다."
                  , style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, height: 1.7,),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              TextButton(
                child: const Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                  prefs.setBool(keyIsFirstLoaded, false);
                },

              ),
            ],
          );
        });
  }
}}