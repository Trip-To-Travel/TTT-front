import 'package:app/const/data.dart';
import 'package:app/model/division_model.dart';
import 'package:app/repository/platform_repository.dart';
import 'package:dio/dio.dart';

class DivisionRepository {
  static Future<List<DivisionModel>> fetchData() async {

    String platform = PlatformRepository.getPlatform();

    final dio = Dio();
    final response = await dio.get(
        'https://apis.data.go.kr/B551011/KorService1/areaCode1',
        queryParameters: {
          '_type' : 'json',
          'MobileOS' : platform,
          'MobileApp' : 'TTT',
          'serviceKey' : serviceKey,
          'numOfRows': 17
        }
    );

    return response.data['response']['body']['items']['item']
        .map<DivisionModel>(
            (item) => DivisionModel.fromJson(json: item),
    ).toList();
  }
}

class AreaCodeRepository{
  static Future<int> totalCount(String areaCode) async {
    String platform = PlatformRepository.getPlatform();

    final dio = Dio();
    final response = await dio.get(
        'https://apis.data.go.kr/B551011/KorService1/areaCode1',
        queryParameters: {
          '_type' : 'json',
          'MobileOS' : platform,
          'MobileApp' : 'TTT',
          'serviceKey' : serviceKey,
          'areaCode': areaCode,
        }
    );
    print(response.data['response']['body']['totalCount']);
    return response.data['response']['body']['totalCount'].toInt();
  }

  static Future<List<DivisionModel>> fetchData(String areaCode) async {
    int? totalCount;
    String platform = PlatformRepository.getPlatform();

    switch(areaCode){
      case '1': // 서울
        totalCount = 25;
        break;
      case '2': // 인천
        totalCount = 10;
        break;
      case '3': // 대전
        totalCount = 5;
        break;
      case '4': // 대구
        totalCount = 9;
        break;
      case '5': // 광주
        totalCount = 5;
        break;
      case '6': // 부산
        totalCount = 16;
        break;
      case '7': // 울산
        totalCount = 5;
        break;
      case '8': //세종특별자치시
        totalCount = 1;
        break;
      case '31': //경기도
        totalCount = 31;
        break;
      case '32': //강원도
        totalCount = 18;
        break;
    }

    final dio = Dio();
    final response = await dio.get(
        'https://apis.data.go.kr/B551011/KorService1/areaCode1',
        queryParameters: {
          '_type' : 'json',
          'MobileOS' : platform,
          'MobileApp' : 'TTT',
          'serviceKey' : serviceKey,
          'areaCode': areaCode,
          'numOfRows': totalCount
        }
    );

    return response.data['response']['body']['items']['item']
        .map<DivisionModel>(
          (item) => DivisionModel.fromJson(json: item),
    ).toList();
  }
}