
import 'package:flutter/material.dart';


class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key }) :super (key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              decoration:  BoxDecoration(color: Colors.lightBlue
                  ,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )
              )
              ,
              accountName: Text('한철진'),
              accountEmail: Text('학번 : 201607284'),
             // onDetailsPressed: () {
               // print('arrow is clicked');
              //},


              currentAccountPicture: CircleAvatar(
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
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.lightBlue,
              ),
              title: const Text("로그아웃", style: TextStyle(fontSize: 18,color: Colors.lightBlue),),
              onTap: () {},
            ),
             const ListTile(title: Text("학생 지원처 : 02-xxxx-xxxx",style: TextStyle(fontSize: 18),),)
         
         
         
         
          ]
      )
    );
  }


}
