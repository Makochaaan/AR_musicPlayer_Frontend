import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../page/addInfoPage.dart';

class DisplayImageWidget extends StatefulWidget {
  final int index;
  final List<XFile> pictureList;

  DisplayImageWidget({required this.index, required this.pictureList});

  @override
  _DisplayImageWidgetState createState() => _DisplayImageWidgetState();
}

class _DisplayImageWidgetState extends State<DisplayImageWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return AddInfoPage(picture: widget.pictureList[widget.index]);
          }),
        );
      },
      
      child: SizedBox(
        child: Card(
          margin: const EdgeInsets.all(30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.file(File(widget.pictureList[widget.index].path)),
        ),
      ),
    );
  }
}
