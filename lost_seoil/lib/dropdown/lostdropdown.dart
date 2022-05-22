import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _valueList = ['전체', '전자기기', '카드','지갑','충전기','책','기타'];
var _selectedValue = '전체';

class Lostdropdown extends StatefulWidget {
  const Lostdropdown({Key? key}) : super(key: key);

  @override
  LostdropdownButton createState() => LostdropdownButton();
}

class LostdropdownButton extends State<Lostdropdown> {
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
