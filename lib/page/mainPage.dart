import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'addImagePage.dart';

class MainPage extends StatefulWidget {
  @override 
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<XFile> pictureList = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('画像一覧'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 5,
            childAspectRatio: 0.8,
          ),
        itemCount: pictureList.length,
        itemBuilder: (context, index){
          return SizedBox(
                child: Card(
                  margin: const EdgeInsets.all(30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior:
                      Clip.antiAliasWithSaveLayer, // Cardと被ったWidgetをCardの形に保持する
                  child: Image.file(File(pictureList[index].path)),
                ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()  async {

          final newListComponent = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return AddImagePage();
            }),
          );
          if (newListComponent != null) {
            setState(() {
              pictureList.add(newListComponent);
            });
          }
        },
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar:Container(
        height: 60,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home),
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
              ),
              child:IconButton(
                onPressed: () {},
                icon: const Icon(Icons.camera_alt_rounded),
              ), 
            ),
            
            IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}