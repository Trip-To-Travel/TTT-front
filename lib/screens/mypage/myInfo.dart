import 'package:app/screens/mypage/updatePassword.dart';
import 'package:app/screens/mypage/updateUserInfo.dart';
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
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("내 정보", style: TextStyle(color: Colors.black, fontSize: 16),),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container( // 현재의 '내 정보'들: 아이디, 닉네임, 이메일
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                color: const Color(0xffebebeb),
                child: Column(
                  children: [
                    Row( // 아이디
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("아이디"),
                        Text("testuser"),
                      ],
                    ),
                    Row( // 닉네임
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("닉네임"),
                        Text("티티티닉네임"),
                      ],
                    ),
                    Row( // 이메일
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("이메일"),
                        Text("email@email.com"),
                      ],
                    ),
                  ],
                ),
              ),
              Column( // 메뉴
                children: [
                  InkWell( // 비밀번호 변경
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdatePassword()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("비밀번호 변경"),
                          Icon(Icons.arrow_forward_ios_sharp, size: 16)
                        ],
                      ),
                    ),
                  ),
                  InkWell( // 회원정보 변경
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateUserInfo()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("회원정보 변경"),
                          Icon(Icons.arrow_forward_ios_sharp, size: 16)
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}