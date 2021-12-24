import 'package:flutter/material.dart';
import 'package:flutter_apppl/helper/scolors.dart';

class TextContainer extends StatelessWidget {
  String? data;
  String? heading;

  TextContainer({this.data, this.heading});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      color: Scolors.grey,
      child: Column(
        children: [
          Text(heading!,style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),),
          Text(data!),
        ],
      ),
    );
  }
}
