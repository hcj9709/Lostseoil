
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lost_seoil/dropdown/lostdropdown.dart';

class Getwrite extends StatefulWidget {
  const Getwrite({Key? key}) : super(key: key);
  @override
  MyGetwrite createState() => MyGetwrite();

}

class MyGetwrite extends State<Getwrite> {
  HtmlEditorController editcontroller = HtmlEditorController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:  Scaffold(
          resizeToAvoidBottomInset: true , //이걸넣어 키보드가 올라왔을떄 화면이 밀리도록 설정
          appBar:AppBar(
            title: const Text("습득물 게시판 글쓰기"),
            leading:  IconButton(
              icon: const Icon(Icons.arrow_back_ios),color:Colors.white, onPressed: () {
              Navigator.pop(context);
            },) //글쓰기에서 뒤로가기 버튼인데 이거 나중에 보완하는것이 좋을거같음
            ,
          )
          //왼쪽위 메뉴 버튼 누르면 나오는 Drawer
          ,
          body:SingleChildScrollView(
             child: HtmlEditor(
                controller: editcontroller, //required
                 htmlToolbarOptions: const HtmlToolbarOptions(
                     defaultToolbarButtons: [
                       StyleButtons(),
                       ParagraphButtons(lineHeight: false, caseConverter: false)
                     ]
                 ) ,
               htmlEditorOptions: const HtmlEditorOptions(

                  hint: "Your text here...",
                  //initalText: "text content initial, if any",
                ),
                otherOptions: const OtherOptions(
                  height: 400,
                ),
              )
          ) ,

        )
    );

  }


}

