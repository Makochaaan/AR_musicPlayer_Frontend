import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImagePage extends StatefulWidget {
  @override
  _AddImagePageState createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {

  XFile? _image;
  final imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("画像追加ページ"),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height:8),
            Container(
              width: double.infinity,
              
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () async {
                  final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
                  setState(() {
                    if (pickedFile != null){
                      _image = XFile(pickedFile.path);
                    }
                  });
                  if (!mounted) return;
                  Navigator.of(context).pop(_image);
                },
                child: const Text("カメラから追加", style: TextStyle(color: Colors.white)),
              )
            ),
             const SizedBox(height:8),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () async {
                  final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    if (pickedFile != null){
                      _image = XFile(pickedFile.path);
                    }
                  });
                  if (!mounted) return;
                  Navigator.of(context).pop(_image);
                },
                child: const Text("ギャラリーから追加", style: TextStyle(color: Colors.white)),
              )
            ),
            const SizedBox(height:8),
            Container(
              width: double.infinity,
              child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("クリックで戻る")
              ),
            )
          ],
        ),
      ),
    );
  }
}