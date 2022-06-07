//이것은상단바임


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Dialog/dialog.dart';
import '../filter/filter.dart';


class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor:Colors.white ,

        iconTheme: const IconThemeData(
          color: Colors.lightBlue ,//색변경
          size: 45,

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
           // Navigator.push(context,MaterialPageRoute(builder:(context)=>  const Myfilter()));
          },
          ),

        ]

    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55.0);
}