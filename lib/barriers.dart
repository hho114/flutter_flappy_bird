import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  final size;

  Barrier({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: 100,
      decoration: BoxDecoration(
          color: Color.fromRGBO(115, 191, 46, 1),
          // border: Border(
          //   top: BorderSide(width: 5.0, color: Color.fromRGBO(90, 84, 98, 1)),
          //   left: BorderSide(width: 5.0, color: Color.fromRGBO(90, 84, 98, 1)),
          //   right: BorderSide(width: 5.0, color: Color.fromRGBO(90, 84, 98, 1)),
          // ),

          border: Border.all(width: 4, color: Color.fromRGBO(90, 84, 98, 1)),
          borderRadius: BorderRadius.circular(15)),
    );
  }
}
