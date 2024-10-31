import 'package:chatify/widgets/top_bar.dart';
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
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceHeight * 0.03,
        vertical: _deviceWidth * 0.02,
      ),
      height: _deviceHeight * 0.98,
      width: _deviceWidth * 0.97,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
          ),
          TopBar(
            barTitle: "Chats",
            fontSize: 25,
            primaryAction: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.logout,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
