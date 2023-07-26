import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class YearEnd extends StatefulWidget {
  const YearEnd({super.key});

  @override
  State<YearEnd> createState() => _YearEndState();
}

class _YearEndState extends State<YearEnd> {
  int current = 0;

  int currentYear = 2023; // todo: 금년도
  String userNickname = "테스트트래블러"; // todo: 접속 중인 사용자의 닉네임/이름

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    List yearEndList = [
      {
        "text": "반가워요",
        "image": "https://images.unsplash.com/photo-1474376962954-d8a681cc53b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8dHJpcCx0cmF2ZWx8fHx8fHwxNjkwMjAyMDQw&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080",
      },
      {
        "text": "좋아해요",
        "image": "https://images.unsplash.com/photo-1451337516015-6b6e9a44a8a3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8dHJpcCx0cmF2ZWx8fHx8fHwxNjkwMjAyMTM5&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080",
      },
      {
        "text": "감사해요",
        "image": "https://images.unsplash.com/photo-1444210971048-6130cf0c46cf?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8dHJpcCx0cmF2ZWx8fHx8fHwxNjkwMjAyMTc0&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080",
      },
    ];

    AppBar appBar = AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: const Text("연말정산", style: TextStyle(color: Colors.black, fontSize: 16),),
    );

    Widget yearEndSlider() {
      return CarouselSlider(
        options: CarouselOptions(
          height: deviceHeight - 2 * appBar.preferredSize.height, // 하단 nav bar까지 고려해서 `* 2` 했어요
          viewportFraction: 0.85,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) { // indicator 조작 위해
            setState(() {
              current = index;
            });
          },
        ),
        items: yearEndList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.amber
                ),
                child: Text('$i', style: TextStyle(fontSize: 16.0),),
              );
            },
          );
        }).toList(),
      );
    }

    Widget sliderIndicator() { // indicator todo: 아직 정상 작동 안함
      return Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: yearEndList.asMap().entries.map((entry) {
            return Container(
              width: 18,
              height: 6,
              margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white.withOpacity(current == entry.key ? 0.9 : 0.4),
              ),
            );
          }).toList(),
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
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
              child: Row(
                children: [
                  Text(
                    userNickname,
                    style: const TextStyle(
                      color: Color(0xff76BDFF),
                    ),
                  ),
                  const Text(" 님의 올 한 해 기록을 정리해 보았어요.")
                ],
              )
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                yearEndSlider(),
                sliderIndicator(),
              ],
            ),
          )
        ]
      ),
    );
  }
}
