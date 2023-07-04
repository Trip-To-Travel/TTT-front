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
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("비밀번호 변경", style: TextStyle(color: Colors.black, fontSize: 16),),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff76BDFF),
                    )
                  ),
                  labelText: "비밀번호"
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff76BDFF),
                    )
                  ),
                  labelText: "비밀번호 확인"
                ),
              ),
            ),
            const BtnUpdate() // 변경 버튼
          ],
        ),
      ),
    );
  }
}

class BtnUpdate extends StatelessWidget {
  const BtnUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Ink(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Color(0xff76BDFF),
            borderRadius: BorderRadius.all(
                Radius.circular(5)
            )
        ),
        child: InkWell(
          onTap: () {
            print("비밀번호 변경 POST 요청");
          },
          borderRadius: const BorderRadius.all(
              Radius.circular(5)
          ),
          child: Container(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: const Text(
                "변경",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              )
          ),
        ),
      ),
    );
  }
}
