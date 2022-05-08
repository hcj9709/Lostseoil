//이것은상단바임


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Dialog/dialog.dart';


class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor:Colors.white ,
        titleTextStyle:const TextStyle(color:Colors.lightBlue , fontSize: 35 , fontWeight: FontWeight.bold) ,

        iconTheme: const IconThemeData(
          color: Colors.lightBlue ,//색변경
          size: 45,

        ),

        title: const Text("LOST 서일", textAlign: TextAlign.left ,)
        //타이틀
        ,

        actions: <Widget>[
          const MyPopUp()  , // 다이얼로그 팝업 열리는 함수임
          IconButton(
            visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0), //이부분이 줄여주는 부분이다.
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.notifications),color:Colors.lightBlue, onPressed: () {
          },),

        ]

    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55.0);
}