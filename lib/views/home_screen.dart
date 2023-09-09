// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imageList = [
    "https://imgs.search.brave.com/WfVQr0FKsyl5IrNAREg_qHRk6lA3n71cKlHR-aLrGXI/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE2/ODI2ODY1ODAwMzYt/YjVlMjU5MzJjZTlh/P2l4bGliPXJiLTQu/MC4zJml4aWQ9TTN3/eE1qQTNmREY4TUh4/bFpHbDBiM0pwWVd3/dFptVmxaSHd4TVh4/OGZHVnVmREI4Zkh4/OGZBPT0mdz0xMDAw/JnE9ODA.jpeg",
    "https://imgs.search.brave.com/9Avtd4FbTK8bTQS0WsTpZxXJnr84V89VVIBu4ibAUCY/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9jZG4u/cGl4YWJheS5jb20v/cGhvdG8vMjAyMy8w/OC8wOS8xOC80OC9z/dW5mbG93ZXJzLTgx/ODAxNDdfNjQwLmpw/Zw",
    "https://imgs.search.brave.com/I5cZ-PdVqu_A8197gy4XjM1MedKA-fJ_OS4EbV-L9SQ/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE0/MzE0MTEyMDc3NzQt/ZGEzYzczMTFiNWU4/P2l4bGliPXJiLTQu/MC4zJml4aWQ9TTN3/eE1qQTNmREI4TUh4/elpXRnlZMmg4TWpC/OGZHNWhkSFZ5WVd4/OFpXNThNSHg4TUh4/OGZEQT0mdz0xMDAw/JnE9ODA.jpeg",
    "https://imgs.search.brave.com/j6_YF7-88KtWWDZDnKpICTJAgSwpwB2iw7fPx1LA83U/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTA2/ODU2NjU4L3Bob3Rv/L2JlYXV0aWZ1bC1u/YXR1cmUtYXQtbW9y/bmluZy1pbi1taXN0/eS1zcHJpbmctZm9y/ZXN0LXdpdGgtc3Vu/LmpwZz9zPTYxMng2/MTImdz0wJms9MjAm/Yz01T3lLM2RvVTBI/NE9HSHVlTjFDb2Ey/cjlkZWlXeWx5X3NK/UlNkZGdSblJVPQ",
    "https://imgs.search.brave.com/9Avtd4FbTK8bTQS0WsTpZxXJnr84V89VVIBu4ibAUCY/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9jZG4u/cGl4YWJheS5jb20v/cGhvdG8vMjAyMy8w/OC8wOS8xOC80OC9z/dW5mbG93ZXJzLTgx/ODAxNDdfNjQwLmpw/Zw",
    "https://imgs.search.brave.com/4PfCdOgqEjHrPEaFGwrqkdTS55PDKMG3tqhVYPPWe60/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9jZG4u/cGl4YWJheS5jb20v/cGhvdG8vMjAxNi8w/MS8wOC8xMS81Ny9i/dXR0ZXJmbGllcy0x/MTI3NjY2XzY0MC5q/cGc",
    "https://imgs.search.brave.com/uJH9TM5f7w87m8Sl-qxptFfhS6C2nnMfmz6ZjIcUEB0/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by9i/ZWF1dGlmdWwtdHJl/ZS1taWRkbGUtZmll/bGQtY292ZXJlZC13/aXRoLWdyYXNzLXdp/dGgtdHJlZS1saW5l/LWJhY2tncm91bmRf/MTgxNjI0LTI5MjY3/LmpwZz9zaXplPTYy/NiZleHQ9anBn",
    "https://imgs.search.brave.com/WuZOH6cEBdbBfP-VLrNV8nzTksEdeipWH72U1SfSKqg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTA5/MzExMDExMi9waG90/by9waWN0dXJlc3F1/ZS1tb3JuaW5nLWlu/LXBsaXR2aWNlLW5h/dGlvbmFsLXBhcmst/Y29sb3JmdWwtc3By/aW5nLXNjZW5lLW9m/LWdyZWVuLWZvcmVz/dC13aXRoLXB1cmUu/anBnP3M9NjEyeDYx/MiZ3PTAmaz0yMCZj/PWxwUTFzUUk0OWJZ/YlRwOVdRX0VmVmx0/QXFTUDFEWGcwSWE3/QVBUamp4ejQ9",
  ];

  Future<void> _saveImage(BuildContext context, int index) async {
    String? message;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      // Download image
      final http.Response response =
          await http.get(Uri.parse(imageList[index]));

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/image.png';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk';
      }
    } catch (e) {
      message = 'An error occurred while saving the image';
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Gallery"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: imageList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 200,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imageList[index]),
                  fit: BoxFit.fill,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () => _saveImage(context, index),
                    icon: Icon(
                      Icons.download,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
