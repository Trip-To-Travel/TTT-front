import 'package:app/screens/mypage/myInfo.dart';
import 'package:app/screens/mypage/yearEnd.dart';
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
          centerTitle: true,
          title: const Text("마이페이지", style: TextStyle(color: Colors.black, fontSize: 16,),),
          actions: [
            IconButton(
                onPressed: () {
                  print("알림 목록으로 이동 - 추후 삭제될 수도");
                },
                icon: const Icon(Icons.notifications_outlined))
          ],
        ),
        body: SafeArea(
          child: Container(
              color: const Color(0xffebebeb),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 추후 메뉴 추가로 인해 스크롤 메뉴가 될 시, 해당 속성은 불필요 할 듯
                children: [
                  Column( // 상단
                    children: [
                      Container( // 프로필 사진, 프로필 정보(닉네임)
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
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
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage('assets/images/mockimg1.jpg'),
                                              fit: BoxFit.cover
                                          )
                                      )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
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
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyInfo()));
                              },
                              child: Row(
                                children: const [
                                  Text(
                                    "내 정보 ",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.end,
                                  ),
                                  Icon(Icons.arrow_forward_ios_sharp, size: 16,)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Column( // 안내: 연말정산, 공지사항, 자주하는 질문, 1:1 문의
                        children: [
                          Container( // 타이틀
                            margin: const EdgeInsets.fromLTRB(16, 16, 16, 2),
                            alignment: Alignment.bottomLeft,
                            child: const Text(
                              "안내",
                            ),
                          ),
                          Container( // 메뉴들 수납 공간
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                            child: Column(
                              children: [
                                Container( // 메뉴: 안내 > 연말정산
                                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const YearEnd()));
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                                child: const Icon(
                                                  Icons.airplane_ticket_sharp,
                                                  color: Colors.grey,
                                                )
                                            ),
                                            const Text(
                                              "연말정산",
                                            )
                                          ],
                                        ),
                                        const Icon(Icons.arrow_forward_ios_sharp, size: 16)
                                      ],
                                    ),
                                  ),
                                ),
                                Container( // 메뉴: 안내 > 공지사항
                                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                                  child: InkWell(
                                    onTap: () {
                                      print("공지사항 페이지로 이동"); // todo
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                                child: const Icon(
                                                  Icons.announcement_sharp,
                                                  color: Colors.grey,
                                                )
                                            ),
                                            const Text(
                                              "공지사항",
                                            )
                                          ],
                                        ),
                                        const Icon(Icons.arrow_forward_ios_sharp, size: 16)
                                      ],
                                    ),
                                  ),
                                ),
                                Container( // 메뉴: 안내 > 자주하는 질문
                                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                                  child: InkWell(
                                    onTap: () {
                                      print("자주하는 질문 페이지로 이동"); // todo
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                                child: const Icon(
                                                  Icons.question_mark_sharp,
                                                  color: Colors.grey,
                                                )
                                            ),
                                            const Text(
                                              "자주하는 질문",
                                            )
                                          ],
                                        ),
                                        const Icon(Icons.arrow_forward_ios_sharp, size: 16)
                                      ],
                                    ),
                                  ),
                                ),
                                Container( // 메뉴: 안내 > 1:1 문의
                                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                                  child: InkWell(
                                    onTap: () {
                                      print("1:1 문의 페이지로 이동"); // todo
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                                child: const Icon(
                                                  Icons.question_answer_sharp,
                                                  color: Colors.grey,
                                                )
                                            ),
                                            const Text(
                                              "1:1 문의",
                                            )
                                          ],
                                        ),
                                        const Icon(Icons.arrow_forward_ios_sharp, size: 16)
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
                        padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                        child: Row( // 이용약관, 설정, 로그아웃
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                print("이용약관 페이지로 이동"); // todo
                              },
                              child: const Text("이용약관"),
                            ),
                            const Text("|", style: TextStyle(color: Colors.black12),),
                            InkWell(
                              onTap: () {
                                print("설정 페이지로 이동"); // todo
                              },
                              child: const Text("설정"),
                            ),
                            const Text("|", style: TextStyle(color: Colors.black12),),
                            InkWell(
                              onTap: () {
                                print("로그아웃 되기"); // todo
                              },
                              child: const Text("로그아웃"),
                            ),
                          ],
                        ),
                      ),
                      InkWell( // Trip To Travel 소개하기!(친구초대) 카카오톡 메시지 api 같은거 쓰면 좋겠네요
                        onTap: () {
                          print("친구초대"); // todo
                        },
                        child: Container(
                            color: const Color(0xff76BDFF),
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.person_add_alt_sharp,
                                  color: Colors.white,
                                ),
                                Text(
                                  " Trip To Travel 소개하기",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                )
                              ],
                            )
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