
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchLog extends StatefulWidget {
  const SwitchLog({Key? key}) : super(key: key);

  @override
  SwitchLogin createState() => SwitchLogin();
}

class SwitchLogin extends State<SwitchLog> {
  bool _isChecked = false;
  @override

  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
        child:SizedBox(
          height: 35,
        child: Row(
          children: <Widget>[
            Switch(
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value;
                });
              },
            )
            ,
            const Text("로그인 상태 유지",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)

          ],
        ),
        )
    );
  }
}