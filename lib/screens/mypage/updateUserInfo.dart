import 'package:flutter/material.dart';

class UpdateUserInfo extends StatelessWidget {
  const UpdateUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("회원정보 변경", style: TextStyle(color: Colors.black, fontSize: 16),),
      ),
      body: SafeArea(
        child: Column(
          
        ),
      ),
    );
  }
}
