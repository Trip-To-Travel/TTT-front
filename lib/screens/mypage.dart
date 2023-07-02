import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("마이페이지", style: TextStyle(color: Colors.black, fontSize: 16,),),
          actions: [
            IconButton(
                onPressed: () {
                  print("알림 목록으로 이동 - 추후 삭제될 수도");
                },
                icon: Icon(Icons.notifications_outlined))
          ],
        ),
        body: SafeArea(
          child: Container(
            color: Color(0xffebebeb),
            padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  // decoration: BoxDecoration(
                  //     color: Colors.white,
                  //   border: Border.all(
                  //     color: Colors.white,
                  //   ),
                  //   borderRadius: BorderRadius.all(Radius.circular(4))
                  // ),
                  child: Row( // 프로필 사진, 프로필 정보(닉네임)
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              print("클릭 시, 프로필 이미지 변경으로 이동");
                            },
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/mockimg1.jpg'),
                                        fit: BoxFit.cover
                                    )
                                )
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "티티티닉네임",
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "email@email.com",
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () { 
                            print("내 정보 페이지로 이동");
                          },
                          child: Text(
                            "내 정보 >",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            )
          ),
        )
    );
  }
}
