import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'dataHolder.dart';

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
    int MAX_SIZE = 4 * 1024 * 1024;
    //print("current indeex is " + widget.index.toString() + '.jpg');
    if (!requestedIndexes.contains(widget.index)) {
      ref
          .child(widget.index.toString() + '.jpg')
          .getData(MAX_SIZE)
          .then((data) {
        if (mounted) {
          setState(() {
            imageFile = data;
          });
        }

        imageData.putIfAbsent(widget.index, () {
          return data;
        });
      }).catchError((onError) {
        print("error is " + onError.toString());
      });
    }
    requestedIndexes.add(widget.index);
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
    super.initState();
    //print("init state is called");
    if (!imageData.containsKey(widget.index)) {
      loadImage();
    } else {
      //print(imageData);
      imageFile = imageData[widget.index];
    }
  }

  @override
  Widget build(BuildContext context) {
    return getImage();
  }
}
