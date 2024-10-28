import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.amber,
    )
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
        currentIndex: _currentPage,
        onTap: (index) => setState(() {
          _currentPage = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_sharp,
            ),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.supervised_user_circle_sharp,
            ),
            label: "Users",
          ),
        ],
      ),
    );
  }
}
