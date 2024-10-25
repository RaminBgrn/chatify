import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// custom button for all
class RoundedImageNetwork extends StatelessWidget {
  final String imagePath;
  final double size;
  const RoundedImageNetwork({
    required this.imagePath,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(size),
        color: Colors.black,
      ),
    );
  }
}

class RoundedImageLocal extends StatelessWidget {
  final PlatformFile image;
  final double size;
  const RoundedImageLocal({required this.image, required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    log(image.path!);
    return ClipRRect(
      borderRadius: BorderRadius.circular(size),
      child: Container(
        width: size,
        height: size,
        color: Colors.black,
        child: Image.file(
          File(image.path!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
