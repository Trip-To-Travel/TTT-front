import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryModel {
  final String title;
  final String content;
  final List<dynamic> image_list;
  final Map<String, dynamic> user;
  final Timestamp date;

  const DiaryModel({
    required this.title,
    required this.content,
    required this.image_list,
    required this.user,
    required this.date,
  });

  factory DiaryModel.fromFirestore(Map<String, dynamic> json) {
    return DiaryModel(
      title: json["title"],
      content: json["content"],
      image_list: json["image_list"],
      user: json["user"],
      date: json["date"],
    );
  }
  Map<String, dynamic> toFirestore() => {
    "title": title,
    "content": content,
    "image_list": image_list,
    "user": user,
    "date": date,
  };
}
