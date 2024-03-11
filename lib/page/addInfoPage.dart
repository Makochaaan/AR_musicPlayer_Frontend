import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../util/processFile.dart';
import '../component/displayAlbumArt.dart';
import 'dart:typed_data';

class AddInfoPage extends StatefulWidget {

  final XFile picture;
  AddInfoPage({required this.picture});

  @override
  _AddInfoPageState createState() => _AddInfoPageState();
}

class _AddInfoPageState extends State<AddInfoPage> {

  String title = "";
  String artist = "";
  String album = "";
  String pathStr = "";
  File musicFile = File('');
  Uint8List albumArtByte = Uint8List(0);
  int trigger = 0;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("画像情報ページ"),
      ),
      body: SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.all(64),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.file(File(widget.picture.path)),
              Column(children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(children: <Widget>[Text("Picture Data")]),
                ),
                Row(children: [Text("Place:"), Text("a"),]),
                Row(children: [Text("Time:"),  Text("a"),]),
              ]),
              
              Container(
                padding: const EdgeInsets.all(32),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Text("Music"),
                    Container(
                      padding: EdgeInsets.all(32),
                      child:TextButton( child: const Text('Add Music'), 
                        onPressed: () async {
                          final processer = ProcessFile();
                          musicFile = await processer.GetFile();
                          var tag = await processer.GetTag(musicFile);
                          var buffer = await processer.extractAlbumArt(musicFile);
                          if (buffer != null){
                            trigger = 1;
                            setState(() => {
                            pathStr = musicFile.path.toString(), 
                            title = tag[0].toString(),
                            artist = tag[1].toString(),
                            album = tag[2].toString(),
                            albumArtByte = buffer,
                            });
                          } else {
                            setState(() => {
                            pathStr = musicFile.path.toString(), 
                            title = tag[0].toString(),
                            artist = tag[1].toString(),
                            album = tag[2].toString(),
                            });
                          }

                          
                        },
                      ),
                    ),
                  ]),
                  Text(title),
                  Text(artist),
                  Text(album),
                  (trigger==1)?AddAlbumArt(byte: albumArtByte):Text("a"),

                ])
              ),
            ]
          )
        ),
      ),
    );
  }
}