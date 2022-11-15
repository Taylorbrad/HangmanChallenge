import 'package:flutter/material.dart';

class ThanksView extends StatefulWidget{
  @override
  State<ThanksView> createState() => _ThanksViewState();
}

class _ThanksViewState extends State<ThanksView> {
  @override
  Widget build(BuildContext context) {

    //Here we simply return a container with a text thanking the player
    return Container(child: Text("Thanks for Playing!", style: TextStyle(fontSize: 28),));
  }

}