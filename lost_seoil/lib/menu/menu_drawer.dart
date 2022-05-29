
import 'package:flutter/material.dart';
import 'package:lost_seoil/Dialog/logoutDialog.dart';

import '../Dialog/dialog.dart';


class MenuDrawer extends StatefulWidget {
   String name;
   int student_id;
   MenuDrawer({Key? key,required this.student_id , required this.name}) : super(key: key);

  @override
  _MyMenuDrawer createState() => _MyMenuDrawer();
}

class _MyMenuDrawer extends State<MenuDrawer> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        child: ListView(

            padding: EdgeInsets.zero,
            children: <Widget>[
               UserAccountsDrawerHeader(
                decoration:  const BoxDecoration(color: Colors.lightBlue
                    ,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    )
                )
                ,
                accountName: Text(widget.name),
                accountEmail: Text(widget.student_id.toString()),
                // onDetailsPressed: () {
                // print('arrow is clicked');
                //},


                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/banana.png'),
                ),


              )

              ,
              ListTile(
                leading: const Icon(
                  Icons.people,
                  color: Colors.lightBlue,
                ),
                title: const Text("내 글 조회", style: TextStyle(fontSize: 18,color: Colors.lightBlue),),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.chat_bubble_rounded,
                  color: Colors.lightBlue,
                ),
                title: const Text("1:1대화", style: TextStyle(fontSize: 18,color: Colors.lightBlue),),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.lightbulb,
                  color: Colors.lightBlue,
                ),
                title: const Text("FAQ", style: TextStyle(fontSize: 18,color: Colors.lightBlue),),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.warning,
                  color: Colors.lightBlue,
                ),
                title: const Text("신고내역", style: TextStyle(fontSize: 18,color: Colors.lightBlue),),
                onTap: () {},
              ),
              ListTile( //로그아웃 버튼
                leading: const Icon(
                  Icons.logout,
                  color: Colors.lightBlue,
                ),
                title: const Text("로그아웃", style: TextStyle(fontSize: 18,color: Colors.lightBlue),),
                onTap: () async {  Future.delayed(Duration.zero, () => LogoutDialog(context));},
              ),
              const ListTile(title: Text("학생 지원처 : 02-xxxx-xxxx",style: TextStyle(fontSize: 18),),)




            ]
        )
    );
  }
}
