import 'package:flutter/material.dart';

class YearEnd extends StatefulWidget {
  const YearEnd({super.key});

  @override
  State<YearEnd> createState() => _YearEndState();
}

class _YearEndState extends State<YearEnd> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    const int currentYear = 2023; // todo: 금년도
    const String userNickname = "테스트트래블러"; // todo: 접속 중인 사용자의 닉네임/이름

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter( // 타이틀
            child: Container(
              color: Colors.black,
              child: Container(
                width: double.infinity,
                height: deviceHeight * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const NetworkImage("https://source.unsplash.com/featured/?trip,travel"), // todo: 저작권 이슈 위험.. 개발 단계에서 임시로 넣은 것
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
                    )
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$currentYear",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "연말정산 📑",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter( // todo: 여기 InkWell 씌워서, 클릭 시 해당 장소에 대한 정보 나타내도록 하는 건 어떨까?
              child: Text(
                "${userNickname}님의 올 한 해 기록을 정리해 보았어요.",
              ),
            ),
          ),
        ]
      ),
    );
  }
}
