import 'package:flutter/material.dart';
import 'package:app/main.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';


class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late KakaoMapController mapController;

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: KakaoMap(
        onMapCreated: ((controller) async {
          mapController = controller;

          markers.add(Marker(
            markerId: markers.length.toString(),
            latLng: LatLng(33.450705, 126.570677),
            width: 24,
            height: 35,
            markerImageSrc:
            'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png',
          ));

          markers.add(Marker(
            markerId: markers.length.toString(),
            latLng: LatLng(33.450936, 126.569477),
            width: 24,
            height: 35,
            markerImageSrc:
            'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png',
          ));

          markers.add(Marker(
            markerId: markers.length.toString(),
            latLng: LatLng(33.450879, 126.569940),
            width: 24,
            height: 35,
            markerImageSrc:
            'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png',
          ));

          markers.add(Marker(
            markerId: markers.length.toString(),
            latLng: LatLng(33.451393, 126.570738),
            width: 24,
            height: 35,
            markerImageSrc:
            'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png',
          ));

          setState(() {});
        }),
        markers: markers.toList(),
        center: LatLng(33.450701, 126.570667),
      ),
    );
  }
}