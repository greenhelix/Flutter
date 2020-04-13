import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DataImageUpload extends StatefulWidget {
  @override
  _DataImageUploadState createState() => _DataImageUploadState();
}

class _DataImageUploadState extends State<DataImageUpload> {
  File _image;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: _image == null ? Text('No Image') : Image.file(_image),
      ),
    );
  }

  getCameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  getGalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}
