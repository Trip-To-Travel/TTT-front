import 'package:flutter/material.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

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
        title: Text("비밀번호 변경", style: TextStyle(color: Colors.black, fontSize: 16),),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text("비밀번호 변경")
            ],
          ),
        ),
      ),
    );
  }
}
