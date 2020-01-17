import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  int index = 0;
  ImageWidget({this.index});
  @override
  _ImageState createState() => _ImageState();
}

class _ImageState extends State<ImageWidget> {
  StorageReference ref = FirebaseStorage.instance.ref().child('shoes');
  Uint8List imageFile = null;

  void loadImage() {
    print("load image called");
    int MAX_SIZE = 4 * 1024 * 1024;
    print("current indeex is " + widget.index.toString() + '.jpg');
    ref.child(widget.index.toString() + '.jpg').getData(MAX_SIZE).then((data) {
      setState(() {
        imageFile = data;
      });
    }).catchError((onError) {
      print("error is " + onError.toString());
    });
  }

  Widget getImage() {
    return imageFile != null
        ? Image.memory(imageFile, fit: BoxFit.cover)
        : Center(
            child: Text('loading'),
          );
  }

  @override
  void initState() {
    print("init state is called");
    loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getImage();
  }
}
