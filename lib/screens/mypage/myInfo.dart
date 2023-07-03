import 'package:app/screens/mypage/updatePassword.dart';
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
              child: Column(
                children: [
                  Container( // 현재의 '내 정보'들: 아이디, 닉네임, 이메일
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                    color: Color(0xffebebeb),
                    child: Column(
                      children: [
                        Row( // 아이디
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("아이디"),
                            Text("testuser"),
                          ],
                        ),
                        Row( // 닉네임
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("닉네임"),
                            Text("티티티닉네임"),
                          ],
                        ),
                        Row( // 이메일
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("이메일"),
                            Text("email@email.com"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container( // 메뉴
                    child: Column(
                      children: [
                        Container( // 비밀번호 변경
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePassword()));
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("비밀번호 변경"),
                                  Icon(Icons.arrow_forward_ios_sharp, size: 16)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container( // 회원정보 변경
                          child: InkWell(
                            onTap: () {
                              print("회원정보 변경 페이지로 이동");
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("회원정보 변경"),
                                  Icon(Icons.arrow_forward_ios_sharp, size: 16)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
          ),
        )
    );
  }
}