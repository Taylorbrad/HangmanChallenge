
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  // const d ({Key key}) : super(key: key);
  final String title;

  CustomButton(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
        child: Text(
            title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        decoration: BoxDecoration(color: Color.fromARGB(255, 31, 229, 146),
        borderRadius: BorderRadius.circular(5)),
    );
  }

}