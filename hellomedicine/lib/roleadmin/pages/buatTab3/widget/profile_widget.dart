import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medhealth/theme.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key key,
    this.imagePath,
    this.isEdit = false,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = redColor;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 4,
            right: 6,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = base64.decode(imagePath);
    // previous image ? : antara Image.Asset atau Image.Network. imagePath.contains(http) ??

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: 230,
            height: 150,
            child: Image.memory(
              image,
              fit: BoxFit.cover,
            ),
          ),
          onTap: onClicked,
        ),
      ),
      // child: Ink.image(
      //   image: image as ImageProvider,
      //   fit: BoxFit.cover,
      //   //default 128-127 ClipOval
      //   width: 220,
      //   height: 150,
      //   child: InkWell(onTap: onClicked),
      // ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 2, // Tebal Outline Putih
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.photo_camera : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    Widget child,
    double all,
    Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
