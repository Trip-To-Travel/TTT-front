import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YearEnd extends StatefulWidget {
  const YearEnd({super.key});

  @override
  State<YearEnd> createState() => _YearEndState();
}

class _YearEndState extends State<YearEnd> {
  int current = 0;

  int currentYear = 2023; // todo: 금년도
  String userNickname = "테스트트래블러"; // todo: 접속 중인 사용자의 닉네임/이름

  // 연말정산 widget 01
  int howManyDiary = 230; // 하루에 한 개 씩만 작성 가능 하므로, 천 단위마다 ','가 들어가는 형식 처리까지는 생략함. todo: 금년도 작성한 다이어리 총 개수

  // 연말정산 widget 02
  String favoriteTheme = '카페'; // todo; 금년도 가장 자주 찾은 장소(테마)
  String favoriteThemeThumbnail = "https://source.unsplash.com/featured/?trip,travel"; // todo: 임시 이미지 경로
  int howManyTimesVisits = 12; // todo: 해당 테마인 장소들에 방문한 총 횟수

  // 연말정산 widget 03
  String longestDiary = '2023-07-31'; // todo: 금년도 내용이 가장 긴 다이어리가 작성된 날짜
  String longestDiaryThumbnail = "https://source.unsplash.com/featured/?trip,travel"; // todo: 임시 이미지 경로
  int numberOfCharacter = 13435; // todo:

  // 연말정산 widget 04
  int mostActiveMonth = 7; // todo: 금년도 다이어리가 가장 많이 작성된 달
  int howManyDiaryMonth = 29; // todo: mostActiveMonth에 작성된 다이어리 개수
  String activeMonthImage01 = "https://source.unsplash.com/featured/?trip,travel"; // todo: 임시 이미지 경로
  String activeMonthImage02 = "https://source.unsplash.com/featured/?trip,travel"; // todo: 임시 이미지 경로
  String activeMonthImage03 = "https://source.unsplash.com/featured/?trip,travel"; // todo: 임시 이미지 경로
  String activeMonthImage04 = "https://source.unsplash.com/featured/?trip,travel"; // todo: 임시 이미지 경로
  String activeMonthImage05 = "https://source.unsplash.com/featured/?trip,travel"; // todo: 임시 이미지 경로

  // 연말정산 widget 05
  String multipleVisitsThumbnail = "https://source.unsplash.com/featured/?trip,travel"; // todo: 임시 이미지 경로
  String multipleVisitsName = "스너글"; // todo: 금년도 가장 많이 방문했던 장소의 place name
  String multipleVisitsAddress = "충북 청주시 서원구 성봉로242번길 51 1층"; // todo: 금년도 가장 많이 방문했던 장소의 road address(도로명)
  int multipleVisitsCount = 132; // todo: 금년도 가장 많이 방문했던 장소의 방문자 수 -> select ~ count ~ order by desc ~ limit 1 이런식으로 하면 되려나

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    List yearEndList = [
      yearEndItem01(userNickname, howManyDiary, deviceWidth),
      yearEndItem02(favoriteTheme, favoriteThemeThumbnail, howManyTimesVisits, deviceWidth),
      yearEndItem03(longestDiary, longestDiaryThumbnail, numberOfCharacter, deviceWidth),
      yearEndItem04(mostActiveMonth, howManyDiaryMonth, deviceWidth,
          activeMonthImage01, activeMonthImage02, activeMonthImage03, activeMonthImage04, activeMonthImage05),
      yearEndItem05(multipleVisitsThumbnail, multipleVisitsName, multipleVisitsAddress, multipleVisitsCount, deviceWidth),
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
              return i; // page 각각 디자인, 구성이 다름
            },
          );
        }).toList(),
      );
    }

    Widget sliderIndicator() { // indicator
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
            sliver: SliverToBoxAdapter(
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

Widget yearEndItem01(String nickname, int howManyDiary,
    final deviceWidth) { // 금년도 작성한 총 다이어리 갯수
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.black87,
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 80, 10, 80),
          child: Text(
              "올해\n$nickname 님은\n총 $howManyDiary 장의 다이어리를\n작성했어요.",
            style: const TextStyle(
              color: Color(0xffE9E9E9),
              fontSize: 30
            ),
          ),
        ),
        Positioned(
          left: deviceWidth * 0.12,
          bottom: 0,
          child: Container(
              width: deviceWidth,
              height: deviceWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/year-end-graphic-01.png'),
                  fit: BoxFit.fitWidth,
                ),
              )
          ),
        ),
      ],
    ),
  );
}

Widget yearEndItem02(String favoriteTheme, String favoriteThemeThumbnail, int howManyTimesVisits,
    final deviceWidth) { // 금년도 가장 자주 찾은 장소(테마 별 카운팅)
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: const Color(0xff181B4D),
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(10, 80, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "가장 자주 찾은\n테마 장소는\n\'$favoriteTheme\' 에요.",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Color(0xff71FDE0),
                    fontSize: 32
                ),
              ),
              Text(
                "\'$favoriteTheme\' 테마 장소에 방문한 총 횟수 $howManyTimesVisits 회",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Color(0xff71FDE0),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: deviceWidth * 0.1,
          bottom: deviceWidth * 0.034,
          child: Container(
              width: deviceWidth,
              height: deviceWidth * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/year-end-02-background-graphic.png'),
                  fit: BoxFit.fitWidth,
                ),
              )
          ),
        ),
        Positioned(
          right: deviceWidth * 0.1,
          bottom: deviceWidth * 0.2,
          child: Container(
            width: deviceWidth,
            height: deviceWidth,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(favoriteThemeThumbnail),
                  fit: BoxFit.cover
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget yearEndItem03(String longestDiary, String longestDiaryThumbnail, int numberOfCharacter,
    final deviceWidth) { // 금년도 가장 길게(내용 byte 길이) 작성한 다이어리
  var f = NumberFormat('###,###,###,###');
  
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: const Color(0xff4d1818),
    child: Stack(
      children: [
        Positioned(
          left: -8,
          top: deviceWidth * 0.1,
          child: Image.asset('assets/images/year-end-03-background-graphic.png'),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: deviceWidth * 0.7,
              height: deviceWidth * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(longestDiaryThumbnail),
                    fit: BoxFit.cover
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(10, 60, 10, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "가장 길게 작성된\n다이어리는 \'$longestDiary\' 의\n기록됐어요.",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Color(0xffffe3e3),
                        fontSize: 32
                    ),
                  ),
                  Text(
                    "\'$longestDiary\' 에 작성된 총 글자 수 ${f.format(numberOfCharacter)} 자",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Color(0xffffe3e3),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget yearEndItem04(int mostActiveMonth, int howManyDiaryMonth, final deviceWidth,
    String activeMonthImage01, String activeMonthImage02, String activeMonthImage03, String activeMonthImage04, String activeMonthImage05) { // 금년도 가장 활발히 작성한 달(월별 다이어리 개수 카운팅)
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: const Color(0xff1c3826),
    child: Stack(
      children: [
        Positioned(
          right: - deviceWidth * 0.2,
          top: - deviceWidth * 0.1,
          width: deviceWidth,
          child: Image.asset('assets/images/year-end-04-background-graphic.png'),
        ),
        Positioned(
          right: -deviceWidth*0.1,
          top: deviceWidth*0.36,
          child: Container(
            width: deviceWidth * 0.36,
            height: deviceWidth * 0.36,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(activeMonthImage02),
                  fit: BoxFit.cover
              ),
            ),
          ),
        ),
        Positioned(
          top: deviceWidth*0.16,
          left: deviceWidth*0.05,
          child: Container(
            width: deviceWidth * 0.44,
            height: deviceWidth * 0.44,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(activeMonthImage01),
                  fit: BoxFit.cover
              ),
            ),
          ),
        ),
        Positioned(
          left: -deviceWidth*0.1,
          bottom: deviceWidth*0.32,
          child: Container(
            width: deviceWidth * 0.36,
            height: deviceWidth * 0.36,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(activeMonthImage03),
                  fit: BoxFit.cover
              ),
            ),
          ),
        ),
        Positioned(
          bottom: deviceWidth*0.12,
          left: deviceWidth*0.2,
          child: Container(
            width: deviceWidth * 0.48,
            height: deviceWidth * 0.48,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(activeMonthImage04),
                  fit: BoxFit.cover
              ),
            ),
          ),
        ),
        Positioned(
          bottom: deviceWidth*0.2,
          right: -deviceWidth*0.2,
          child: Container(
            width: deviceWidth * 0.3,
            height: deviceWidth * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(activeMonthImage05),
                  fit: BoxFit.cover
              ),
            ),
          ),
        ),
        Container( // stack top에 내용 배치.
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$mostActiveMonth월에 가장 활발히\n활동했어요.\n$mostActiveMonth월에 작성된 다이어리는 총 $howManyDiaryMonth장 입니다.",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Color(0xffecffe3),
                    fontSize: 32
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget yearEndItem05(String multipleVisitsThumbnail,
    String multipleVisitsName, String multipleVisitsAddress, int multipleVisitsCount,
    final deviceWidth) { // 금년도 여러 번 반복해 방문한 장소
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: const Color(0xff3f2f18),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "여러 번 찾으신 장소가 있어요.",
            style: TextStyle(
                color: Color(0xfffdf8e5),
                fontSize: 32
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: deviceWidth*0.6,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(multipleVisitsThumbnail),
                fit: BoxFit.cover
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                multipleVisitsName,
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Color(0xfffdf8e5),
                    fontSize: 20
                ),
              ),
              Text(
                multipleVisitsAddress,
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Color(0xfffdf8e5),
                ),
              ),
              Text(
                "\n올해 총 $multipleVisitsCount 번 방문",
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Color(0xfffdf8e5),
                    fontSize: 20
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}