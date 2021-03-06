import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imagePickFn;
  UserImagePicker(this.imagePickFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  final picker = ImagePicker();
  void _pickImage() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Select Any Method'),
        content: Container(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                icon: Icon(Icons.camera),
                label: Text('Click an Image'),
                onPressed: () async {
                  final image = await picker.getImage(
                    source: ImageSource.camera,
                    imageQuality: 50,
                    maxWidth: 150,
                  );
                  setState(() {
                    _image = File(image.path);
                  });
                  widget.imagePickFn(_image);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                label: Text('Select an existing Image'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final image = await picker.getImage(
                    source: ImageSource.gallery,
                    imageQuality: 50,
                    maxWidth: 150,
                  );
                  setState(() {
                    _image = File(image.path);
                  });
                  widget.imagePickFn(_image);
                  //Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image) : null,
        ),
        FlatButton.icon(
          icon: Icon(Icons.image),
          label: Text('Add image'),
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
        ),
      ],
    );
  }
}
