import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
final _valueList = ['제목', '제목+내용', '글쓴이'];
var _selectedValue = '제목';

class Mydropdown extends StatefulWidget {
  const Mydropdown({Key? key}) : super(key: key);

  @override
  _MyDemoState createState() => _MyDemoState();
}

class _MyDemoState extends State<Mydropdown> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,

     child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(00.0),
            ),
         child:DropdownButtonHideUnderline(

            child:DropdownButton<String>(
              isExpanded: true,
              value: _selectedValue,
            items: _valueList.map(
            (String value) {
          return DropdownMenuItem <String>(
            value: value,
            child: Text( value,style: const TextStyle(fontSize: 15),),

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
    )
    );


}
}