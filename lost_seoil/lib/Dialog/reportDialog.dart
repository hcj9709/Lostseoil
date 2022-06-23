import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Report { lie,sexual ,other,etc }

Report? _report = Report.lie;
// ignore: non_constant_identifier_names


Future<void>  ReportDialog(BuildContext context ,StateSetter setState) async {
  await showDialog<void>(
      context: context ,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: true,

      builder:(BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(15), //다이얼로그 박스에 대한 패딩
          titlePadding: const EdgeInsets.all(0), //타이틀에대한 패딩
          //contentPadding: const EdgeInsets.all(8), //글 내용에 대한 패딩
          contentPadding: const EdgeInsets.only(top: 0, left: 8,right: 8, bottom: 0),
          actionsPadding:const EdgeInsets.all(0) ,//action거기에 대한 패딩

          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1.0)),
          //Dialog Main Title

          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children:   <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child:Text("신고 사유 선택"
                      )
                  )
              ),
            ],

          ),

          content:GestureDetector(
              onTap: () {
              FocusScope.of(context).unfocus();
              },

          child:SingleChildScrollView(
            child:StatefulBuilder(
             builder: (context, setState) {
               return Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   RadioListTile<Report>(
                       title: Text('허위/사기성 글'),
                       value: Report.lie,
                       groupValue: _report,
                       onChanged: (Report? value) {
                         setState(() => _report = value);
                       }
                   ),
                   RadioListTile<Report>(
                     title: Text("음란/불건전한 내용"),
                     value: Report.sexual,
                     groupValue: _report,
                     onChanged: (Report? value) {
                       setState(() => _report = value);
                     },
                   ),
                   RadioListTile<Report>(
                       title: Text('분실물과 관련이 없는 내용'),
                       value: Report.other,
                       groupValue: _report,
                       onChanged: (Report? value) {
                         setState(() => _report = value);
                       }
                   ),
                   RadioListTile<Report>(
                       title: TextField(
                         onChanged: (value) {
                           setState(() {

                           });
                         },
                         decoration: InputDecoration(hintText: "기타사항 입력"),
                       ),
                       value: Report.etc,
                       groupValue: _report,
                       onChanged: (Report? value) {
                         setState(() => _report = value);
                       }
                   ),
                 ],
               );
             }
        ),
          )
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            TextButton(
              child: const Text("신고"),
              onPressed: () {
                print(_report);
              },

            ),

          ],
        );
      });
}