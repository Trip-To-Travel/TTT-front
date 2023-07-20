import 'package:flutter/material.dart';

class YearEnd extends StatelessWidget {
  const YearEnd({super.key});

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
        title: const Text("연말정산", style: TextStyle(color: Colors.black, fontSize: 16),),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("연말정산 페이지 입니다."),
          ],
        ),
      ),
    );
  }
}
