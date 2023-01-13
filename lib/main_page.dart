import 'package:animations/animations.dart';
import 'package:fade_transition/another_page.dart';
import 'package:fade_transition/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = [
    const HomePage(),
    const AnotherPage(),
  ];

  int _selectedPageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fade Transition')),
      body: PageTransitionSwitcher(
        duration: const Duration(seconds: 3),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child);
        },
        child: IndexedStack(
          // Need a key to let PageTransitionSwitcher fire the anim.
          key: ValueKey<int>(_selectedPageIdx),
          index: _selectedPageIdx,
          children: [..._pages],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => _showDialog(context)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIdx,
        onTap: (value) {
          setState(
            () {
              _selectedPageIdx = value;
            },
          );
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Notes',
            icon: Icon(
              Icons.note,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) {
    return showModal(
      context: context,
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(seconds: 3),
      ),
      builder: (context) {
        return AlertDialog(
          title: const Text('Alert'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
