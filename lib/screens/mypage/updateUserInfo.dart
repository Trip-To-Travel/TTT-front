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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container( // 현재 로그인 중인 사용자의 아이디
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  color: const Color(0xffebebeb),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column( // 아이디
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("아이디"),
                          Text(
                              "testuser",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell( // 닉네임 변경
                  onTap: () {
                    print("닉네임 변경 페이지로 이동하거나, dialog로 처리하거나");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("닉네임 변경"),
                        Icon(Icons.arrow_forward_ios_sharp, size: 16)
                      ],
                    ),
                  ),
                ),
                InkWell( // 이메일 변경
                  onTap: () {
                    print("이메일 변경 페이지로 이동하거나, dialog로 처리하거나");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("이메일 변경"),
                        Icon(Icons.arrow_forward_ios_sharp, size: 16)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xffebebeb),
                    width: 1
                  )
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '• Trip To Travel 앱을 통해 정보 변경이 불가능한 경우, \'1:1 문의\'에 문의해 주세요.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 12
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
