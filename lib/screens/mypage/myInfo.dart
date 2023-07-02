import 'package:flutter/material.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("내 정보", style: TextStyle(color: Colors.black, fontSize: 16),),
        ),
        body: SafeArea(
          child: Container(
            child: Text("내 정보"),
          ),
        )
    );
  }
}
