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

  // 연말정산 widget 01
  int howManyDiary = 230; // 하루에 한 개 씩만 작성 가능 하므로, 천 단위마다 ','가 들어가는 형식 처리까지는 생략함. todo: 금년도 작성한 다이어리 총 개수

  // 연말정산 widget 02
  String favoriteTheme = '카페'; // todo; 금년도 가장 자주 찾은 장소(테마)
  String favoriteThemeThumbnail = "https://source.unsplash.com/featured/?trip,travel"; // todo: 임시 이미지 경로

  // 연말정산 widget 03
  String longestDiary = '2023-07-31'; // todo: 금년도 내용이 가장 긴 다이어리가 작성된 날짜
  String longestDiaryThumbnail = "https://source.unsplash.com/featured/?trip,travel"; // todo: 임시 이미지 경로

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
      yearEndItem01(userNickname, howManyDiary),
      yearEndItem02(favoriteTheme, favoriteThemeThumbnail),
      yearEndItem03(longestDiary, longestDiaryThumbnail),
      yearEndItem04(mostActiveMonth, howManyDiaryMonth,
          activeMonthImage01, activeMonthImage02, activeMonthImage03, activeMonthImage04, activeMonthImage05),
      yearEndItem05(multipleVisitsThumbnail, multipleVisitsName, multipleVisitsAddress, multipleVisitsCount),
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

Widget yearEndItem01(String nickname, int howManyDiary) { // 금년도 작성한 총 다이어리 갯수
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.amber,
    padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
    child: Column(
      children: [
        Text("올해 $nickname 님은 $howManyDiary 장의 다이어리를 작성했어요."),
      ],
    ),
  );
}

Widget yearEndItem02(String favoriteTheme, String favoriteThemeThumbnail) { // 금년도 가장 자주 찾은 장소(테마 별 카운팅)
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.amber,
    padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
    child: Column(
      children: [
        Text("가장 자주 찾은 장소는 \'$favoriteTheme\' 에요."),
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(favoriteThemeThumbnail),
                fit: BoxFit.cover
            ),
          ),
        ),
      ],
    ),
  );
}

Widget yearEndItem03(String longestDiary, String longestDiaryThumbnail) { // 금년도 가장 길게(내용 byte 길이) 작성한 다이어리
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.amber,
    padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
    child: Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(longestDiaryThumbnail),
                fit: BoxFit.cover
            ),
          ),
        ),
        Text("가장 길게 작성된 다이어리는 \'$longestDiary\'의 기록이에요."),
      ],
    ),
  );
}

Widget yearEndItem04(int mostActiveMonth, int howManyDiaryMonth,
    String activeMonthImage01, String activeMonthImage02, String activeMonthImage03, String activeMonthImage04, String activeMonthImage05) { // 금년도 가장 활발히 작성한 달(월별 다이어리 개수 카운팅)
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.amber,
    padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
    child: Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(activeMonthImage01),
                fit: BoxFit.cover
            ),
          ),
        ),
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(activeMonthImage02),
                fit: BoxFit.cover
            ),
          ),
        ),
        Text("$mostActiveMonth월에 가장 활발히 활동했어요. $mostActiveMonth월에 작성된 다이어리는 $howManyDiaryMonth장 입니다."),
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(activeMonthImage03),
                fit: BoxFit.cover
            ),
          ),
        ),
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(activeMonthImage04),
                fit: BoxFit.cover
            ),
          ),
        ),
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(activeMonthImage05),
                fit: BoxFit.cover
            ),
          ),
        ),
      ],
    ),
  );
}

Widget yearEndItem05(String multipleVisitsThumbnail,
    String multipleVisitsName, String multipleVisitsAddress, int multipleVisitsCount) { // 금년도 여러 번 반복해 방문한 장소
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.amber,
    padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
    child: Column(
      children: [
        Text("여러 번 방문한 장소가 있어요."),
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(multipleVisitsThumbnail),
                fit: BoxFit.cover
            ),
          ),
        ),
        Text(multipleVisitsName),
        Text(multipleVisitsAddress),
        Text("$multipleVisitsCount 번 방문"),
      ],
    ),
  );
}