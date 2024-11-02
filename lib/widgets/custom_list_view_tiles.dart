import 'package:chatify/widgets/rounded_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomListViewTiles extends StatelessWidget {
  final double height;
  final String title;
  final String subTitle;
  final String imagePath;
  final bool isActive;
  final bool isActivity;
  final Function onTap;

  const CustomListViewTiles(
      {required this.height,
      required this.title,
      required this.subTitle,
      required this.imagePath,
      required this.isActive,
      required this.isActivity,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      minVerticalPadding: height * 0.20,
      leading: RoundedImageNetworkWithStatusIndicator(
        imagePath: imagePath,
        isActive: false,
        size: height / 2,
        key: UniqueKey(),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: isActivity
          ? Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SpinKitThreeBounce(
                  color: Colors.white38,
                  size: height * 0.10,
                )
              ],
            )
          : Text(
              subTitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w300,
              ),
            ),
    );
  }
}
