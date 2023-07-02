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
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 추후 메뉴 추가로 인해 스크롤 메뉴가 될 시, 해당 속성은 불필요 할 듯
              children: [
                Column( // 상단
                  children: [
                    Container( // 프로필 사진, 프로필 정보(닉네임)
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      // decoration: BoxDecoration(
                      //     color: Colors.white,
                      //   border: Border.all(
                      //     color: Colors.white,
                      //   ),
                      //   borderRadius: BorderRadius.all(Radius.circular(4))
                      // ),
                      child: Row(
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
                              child: Row(
                                children: [
                                  Text(
                                    "내 정보 ",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.end,
                                  ),
                                  Icon(Icons.arrow_forward_ios_sharp, size: 16,)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column( // 안내: 연말정산, 공지사항, 자주하는 질문, 1:1 문의
                      children: [
                        Container( // 타이틀
                          margin: EdgeInsets.fromLTRB(16, 8, 16, 2),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "안내",
                          ),
                        ),
                        Container( // 메뉴들 수납 공간
                          color: Colors.white,
                          padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container( // 메뉴: 안내 > 연말정산
                                child: InkWell(
                                  onTap: () {
                                    print("연말정산 페이지로 이동");
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(6),
                                          child: Icon(
                                            Icons.airplane_ticket_sharp,
                                            color: Colors.grey,
                                          )
                                      ),
                                      Text(
                                        "연말정산",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey // -> 연말정산 업데이트 되었을 때는, ttt 테마 색상으로 깜빡이게 하면 어떨까?
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container( // 메뉴: 안내 > 공지사항
                                child: InkWell(
                                  onTap: () {
                                    print("공지사항 페이지로 이동");
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(6),
                                          child: Icon(
                                            Icons.announcement_sharp,
                                            color: Colors.grey,
                                          )
                                      ),
                                      Text(
                                        "공지사항",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container( // 메뉴: 안내 > 자주하는 질문
                                child: InkWell(
                                  onTap: () {
                                    print("자주하는 질문 페이지로 이동");
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(6),
                                          child: Icon(
                                            Icons.question_mark_sharp,
                                            color: Colors.grey,
                                          )
                                      ),
                                      Text(
                                        "자주하는 질문",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container( // 메뉴: 안내 > 1:1 문의
                                child: InkWell(
                                  onTap: () {
                                    print("1:1 문의 페이지로 이동");
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(6),
                                          child: Icon(
                                            Icons.question_answer_sharp,
                                            color: Colors.grey,
                                          )
                                      ),
                                      Text(
                                        "1:1 문의",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column( // 하단
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
                      child: Row( // 이용약관, 설정, 로그아웃
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              child: InkWell(
                                onTap: () {
                                  print("이용약관 페이지로 이동");
                                },
                                child: Text("이용약관"),
                              )
                          ),
                          Text("|", style: TextStyle(color: Colors.black12),),
                          Container(
                              child: InkWell(
                                onTap: () {
                                  print("설정 페이지로 이동");
                                },
                                child: Text("설정"),
                              )
                          ),
                          Text("|", style: TextStyle(color: Colors.black12),),
                          Container(
                              child: InkWell(
                                onTap: () {
                                  print("로그아웃 되기");
                                },
                                child: Text("로그아웃"),
                              )
                          ),
                        ],
                      ),
                    ),
                    Container( // Trip To Travel 소개하기!(친구초대) 카카오톡 메시지 api 같은거 쓰면 좋겠네요
                      child: InkWell(
                        onTap: () {
                          print("친구초대");
                        },
                        child: Container(
                          color: Color(0xff76BDFF),
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                  Icons.person_add_alt_sharp,
                                color: Colors.white,
                              ),
                              Text(
                                " Trip To Travel 소개하기",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ),
        )
    );
  }
}
