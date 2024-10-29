import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => ChatsPageState();
}

class ChatsPageState extends State<ChatsPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.sizeOf(context).height;
    _deviceWidth = MediaQuery.sizeOf(context).width;
    return _buildUi();
  }

  Widget _buildUi() {
    return Scaffold(
      backgroundColor: Colors.cyan,
    );
  }
}
