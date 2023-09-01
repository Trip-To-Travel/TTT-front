import 'dart:ui';

import 'package:app/const/theme.dart';
import 'package:app/model/division_model.dart';
import 'package:app/model/theme_model.dart';
import 'package:app/repository/division_repository.dart';
import 'package:app/screens/ranking/themeRanking.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {

  String? _selectedCity;
  String? _selectedArea;
  List<DivisionModel>? _areaList;
  final List<ThemeModel> _themeList = theme;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<List<DivisionModel>> fetchData() async {
    final divisionModels = await DivisionRepository.fetchData();
    return divisionModels;
  }

  Future<List<DivisionModel>> areaCodeData(String areaCode) async {
    final areaCodeModels = await AreaCodeRepository.fetchData(areaCode);
    return areaCodeModels;
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final idealWidth = deviceWidth / 375;
    final idealHeight = deviceHeight / 667;

    return Scaffold(
      body: FutureBuilder<List<DivisionModel>>(
          future: fetchData(),
          builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Center(
              child: Text("에러가 있습니다."),
            );
          }
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DivisionModel> divisions = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  height: idealHeight * 260,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff040E57), Color(0xff3549AF)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),


                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(flex: 4,),
                        Text(
                          "랭킹 📈",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                        Spacer(flex: 1,),
                        Text(
                          "여행을 떠날 준비가 되셨나요?\n현대 도시의 화려한 경관부터 자연 속의 평화로움까지,\n여러분에게 꼭 맞는 테마를 찾아보세요.\n특별한 추억과 환상적인 경험을 선사할 것입니다.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(flex: 1,),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(8, 9, 8, 9),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Spacer(flex: 1,),
                      SizedBox(
                        width: idealWidth*70,
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text("도"),
                          style: TextStyle(color: Colors.black),
                          value: _selectedCity ?? '1',
                          items: divisions.map((e) => DropdownMenuItem(
                            value: e.code,
                            child: Text(e.name),
                          )).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCity = value;
                              areaCodeData(_selectedCity as String).then((item) => _areaList = item);
                            });
                          },
                        ),
                      ),
                      Spacer(flex: 2,),
                      SizedBox(
                        width: idealWidth*70,
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text("시군구"),
                          style: TextStyle(color: Colors.black),
                          value: _selectedArea ?? '1',
                          items: _areaList?.map((e) => DropdownMenuItem(
                            value: e.code,
                            child: Text(e.name),
                          )).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedArea = value!;
                            });
                          },
                        ),
                      ),
                      Spacer(flex: 1,),
                      IconButton(onPressed: (){

                      }, icon: Icon(Icons.search)),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
                  ),
                  // 화면에 표시될 위젯을 설정
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ThemeRanking(
                            themeCode: _themeList[index].code,
                            image: _themeList[index].imageUrl,
                            theme: _themeList[index].name,))
                          );
                        },
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: _themeList[index].imageUrl,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _themeList[index].name,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ],
                        )
                      );
                    },
                    childCount: _themeList.length,
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
