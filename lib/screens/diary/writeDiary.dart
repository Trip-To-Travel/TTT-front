import 'dart:io';

import 'package:app/const/permission_manager.dart';
import 'package:app/model/diary_model.dart';
import 'package:app/screens/calendar/calendarMain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:native_exif/native_exif.dart';
import 'package:uuid/uuid.dart';

class WriteDiary extends StatefulWidget {
  final DateTime selectedDate;
  final DiaryModel? modifyDiary;
  final String? docId;

  const WriteDiary({super.key, required this.selectedDate, required this.modifyDiary, required this.docId,});

  @override
  State<WriteDiary> createState() => _WriteDiaryState();
}

class _WriteDiaryState extends State<WriteDiary> {
  DateTime _selectedDate = DateTime.now();
  DiaryModel? _modifyDiary;
  String? _docId;

  TextEditingController _titleCon = TextEditingController();
  TextEditingController _contentCon = TextEditingController();

  final koreanDateFormat = DateFormat('E', 'ko_KR');

  final String colName = "diary";
  final String fnTitle = "title";
  final String fnContent = "content";
  final String fnDate = "date";

  List<File>? _selectedImages = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _modifyDiary = widget.modifyDiary;
    _docId = widget.docId;
    _selectedImages = (_modifyDiary != null ? null : []);
    _titleCon = (_modifyDiary != null ? TextEditingController(text: _modifyDiary!.title) : TextEditingController());
    _contentCon = (_modifyDiary != null ? TextEditingController(text: _modifyDiary!.content) : TextEditingController());
  }

  @override
  void dispose() {
    _titleCon!.dispose();
    _contentCon!.dispose();
    super.dispose();
  }

  Future<List<String>?> _imagePickerToUpload(List<File> _imgs) async {
    List<String> _urlStrings = [];
    if (_imgs != null) {
      for (var _img in _imgs) {
        String _imageRef = "diary/user_id/${Uuid().v4()}";
        await FirebaseStorage.instance.ref(_imageRef).putFile(_img);
        final String _urlString =
        await FirebaseStorage.instance.ref(_imageRef).getDownloadURL();
        _urlStrings.add(_urlString);
      }
      return _urlStrings;
    } else {
      return null;
    }
  }

  Future<void> _updateFirestore(Map<String, dynamic> data) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("diary")
        .doc(_docId)
        .update(DiaryModel(
                  title: data['title'].toString(),
                  content: data['content'].toString(),
                  image_list: data['image_list'],
                  user: data['user'],
                  date: Timestamp.fromDate(data['date']),
                ).toFirestore());
  }

  Future<void> _toFirestore(Map<String, dynamic> data) async {
    try {
      DocumentReference<Map<String, dynamic>> _reference =
      FirebaseFirestore.instance.collection("diary").doc();
      await _reference.set(DiaryModel(
        title: data['title'].toString(),
        content: data['content'].toString(),
        image_list: data['image_list'],
        user: data['user'],
        date: Timestamp.fromDate(data['date']),
      ).toFirestore());
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message ?? "")));
    }
  }



  Future<void> _pickImages() async {
    setState(() {
      _loading = true;
    });

    try {
      final List<XFile>? pickedImages = await ImagePicker().pickMultiImage();

      if (pickedImages!= null) {
        List<File> images = [];
        for (var pickedImage in pickedImages) {
          final File imageFile = File(pickedImage.path);
          final exif = await Exif.fromPath(imageFile!.path);
          final attributes = await exif.getAttributes();
          print(attributes);
          images.add(imageFile);
        }

        if(images.length > 3) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('사진 첨부는 최대 3장까지 가능합니다.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _loading = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          setState(() {
            _selectedImages = images;
            _loading = false;
          });
        }
      } else {
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('손상된 이미지 파일입니다.\n다른 이미지를 첨부해주세요.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        title: Text(
          "${DateFormat('yyyy년 MM월 dd일').format(_selectedDate)} (${koreanDateFormat.format(_selectedDate)})",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(onPressed: () async {
            setState(() {
              _loading = true;
            });
            List<String>? imgs = _selectedImages != null ?  await _imagePickerToUpload(_selectedImages!) : null;
              final data = {
                "title": _titleCon!.text,
                "content": _contentCon!.text,
                "user": {"id": "user"},
                "image_list": (_docId != null && _selectedImages == null) ? _modifyDiary!.image_list : imgs,
                "date": _selectedDate,
              };
              await (_docId != null ? _updateFirestore(data) : _toFirestore(data)).then((value) => {
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("성공"),
                    content: Text('다이어리 작성을 완료하였습니다.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _loading = false;
                          });
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CalendarMain()));
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                })
              });

          }, icon: Icon(Icons.check))
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(11, 3, 11, 3),
          child: Column(
            children: [
              SizedBox(
                child: TextField(
                  controller: _titleCon,
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '제목을 입력하세요.',
                    hintStyle: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 1,
                  cursorColor: Color(0xff76BDFF),
                  autofocus: true,
                ),
              ),
              SizedBox(
                child: TextField(
                  controller: _contentCon,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '오늘은 어떤 하루를 보냈나요?\n감정과 경험을 자유롭게 적어주세요.',
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                  cursorColor: Color(0xff76BDFF),
                ),
              ),
              if (_loading)
                const CircularProgressIndicator(),
              _modifyDiary != null && _selectedImages == null ? Expanded(
                child: GridView.count(
                  crossAxisCount: 1,
                  children: List.generate(_modifyDiary!.image_list.length, (index) {
                    return SizedBox(
                      child: Image.network(
                        _modifyDiary!.image_list[index].toString(),
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 100.0,
                      ),
                    );
                  }),
                ),
              ) :
              Expanded(
                child: GridView.count(
                  crossAxisCount: 1,
                  children: List.generate(_selectedImages!.length, (index) {
                    return SizedBox(
                      child: Image.file(
                        _selectedImages![index],
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 100.0,
                      ),
                    );
                  }),
                ),
              ),
            ],
          )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await PermissionManager().requestPermission().then((value) => {
            _pickImages()
          });
        },
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0))
        ),
        child: const Icon(Icons.photo_library_outlined, color: Colors.black,),
      ),
    );
  }
}
