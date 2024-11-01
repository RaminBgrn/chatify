import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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

class RoundedImageNetworkWithStatusIndicator extends RoundedImageNetwork {
  final bool isActive;

  const RoundedImageNetworkWithStatusIndicator({
    required Key super.key,
    required super.imagePath,
    required super.size,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        super.build(context),
        Container(
          height: size * 0.20,
          width: size * 0.20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: isActive ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
