import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String barTitle;
  final Widget? primaryAction;
  final Widget? secondaryAction;
  final double? fontSize;

  const TopBar(
      {required this.barTitle,
      this.primaryAction,
      this.secondaryAction,
      this.fontSize,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.10,
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          secondaryAction ?? const SizedBox(),
          Expanded(
            child: Center(
              child: Text(
                barTitle,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          primaryAction ?? const SizedBox(),
        ],
      ),
    );
  }
}
