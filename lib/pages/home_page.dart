import 'package:chatify/pages/chats_page.dart';
import 'package:chatify/pages/user_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    const ChatsPage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildUi();
  }

  Widget _buildUi() {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(36, 35, 40, 1.0),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentPage,
        onTap: (index) => setState(() {
          _currentPage = index;
        }),
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.chat_bubble_sharp,
              color: Colors.blue,
            ),
            icon: Icon(
              Icons.chat_bubble_sharp,
              color: Colors.grey,
            ),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.supervised_user_circle_sharp,
              color: Colors.blue,
            ),
            icon: Icon(
              Icons.supervised_user_circle_sharp,
              color: Colors.grey,
            ),
            label: "Users",
          ),
        ],
      ),
    );
  }
}
