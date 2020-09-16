import 'package:flutter/material.dart';

class PhotoPage extends StatelessWidget {
  String urlImage;

  PhotoPage(String urlImage) {
    this.urlImage = urlImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TOps'),
        backgroundColor: Color(0xcc4B0082),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Center(
        child: CircleAvatar(
          maxRadius: 150,
          backgroundImage: NetworkImage('https://ucarecdn.com/${urlImage}/-/resize/380x/'),
        ),
      ),
    );
  }
}
