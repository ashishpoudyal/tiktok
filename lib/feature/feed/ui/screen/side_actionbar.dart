import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tiktokui/feature/feed/model/video.dart';

class SideActionBar extends StatelessWidget {
  final Video activeVideo;

  const SideActionBar({Key? key, required this.activeVideo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.favorite,
          size: 60,
          color: Colors.white,
        ),
        Text(
          activeVideo.likes.toString(),
          style: TextStyle(color: Colors.white),
        ),
        Icon(
          Icons.messenger,
          size: 60,
          color: Colors.white,
        ),
        Text(
          activeVideo.comments.toString(),
          style: TextStyle(color: Colors.white),
        ),
        Icon(
          Icons.download,
          size: 60,
          color: Colors.white,
        ),
        Text(
          activeVideo.downloads.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
