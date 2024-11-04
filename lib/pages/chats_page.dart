import 'package:chatify/providers/authentication_provider.dart';
import 'package:chatify/providers/chats_page_provider.dart';
import 'package:chatify/widgets/custom_list_view_tiles.dart';
import 'package:chatify/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => ChatsPageState();
}

class ChatsPageState extends State<ChatsPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late ChatsPageProvider chatsPageProvider;
  late AuthenticationProvider _auth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.sizeOf(context).height;
    _deviceWidth = MediaQuery.sizeOf(context).width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatsPageProvider>(
            create: (_) => ChatsPageProvider(auth: _auth))
      ],
      child: _buildUi(),
    );
  }

  Widget _buildUi() {
    return Builder(builder: (context) {
      chatsPageProvider = context.watch<ChatsPageProvider>();
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
            _chatsList()
          ],
        ),
      );
    });
  }

  Widget _chatsList() {
    return Expanded(
      child: _chatTile(),
    );
  }

  Widget _chatTile() {
    return CustomListViewTiles(
        height: _deviceHeight * 0.10,
        title: 'Ramin Bagheriian',
        subTitle: 'Hello',
        imagePath:
            "https://e7.pngegg.com/pngimages/151/548/png-clipart-chat-room-computer-icons-online-chat-livechat-discussion-group-others-class-monochrome.png",
        isActive: false,
        isActivity: false,
        onTap: () {});
  }
}
