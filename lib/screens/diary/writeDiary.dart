import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WriteDiary extends StatefulWidget {
  final String selectedDate;

  const WriteDiary({super.key, required this.selectedDate});

  @override
  State<WriteDiary> createState() => _WriteDiaryState();
}

class _WriteDiaryState extends State<WriteDiary> {
  String _selectedDate = "";
  List<File> _selectedImages = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }


  Future<void> _pickImages() async {
    setState(() {
      _loading = true;
    });

    try {
      final List<XFile>? pickedImages = await ImagePicker().pickMultiImage();
      if (pickedImages != null) {
        List<File> images = [];
        for (var pickedImage in pickedImages) {
          final File imageFile = File(pickedImage.path);
          images.add(imageFile);
        }
        setState(() {
          _selectedImages = images;
          _loading = false;
        });
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
        title: Text(_selectedDate, style: TextStyle(color: Colors.black, fontSize: 16),),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.check))
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(11, 3, 11, 3),
          child: Column(
            children: [
              SizedBox(
                child: TextField(
                  style: TextStyle(
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
                  decoration: InputDecoration(
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
                CircularProgressIndicator(),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 1,
                  children: List.generate(_selectedImages.length, (index) {
                    return SizedBox(
                      child: Image.file(
                        _selectedImages[index],
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
        onPressed: _pickImages,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0))
        ),
        child: const Icon(Icons.photo_library_outlined, color: Colors.black,),
      ),
    );
  }
}
