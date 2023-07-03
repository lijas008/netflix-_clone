import 'package:flutter/material.dart';
import 'package:netflix/presentation/download_screen/download_screen.dart';
import 'package:netflix/presentation/fast_laugh_screen/fast_laugh_screen.dart';
import 'package:netflix/presentation/home_screen/home_screen.dart';
import 'package:netflix/presentation/main_screen/widgets/bottom_navbar.dart';
import 'package:netflix/presentation/new_and_hot_screen/new_and_hot_screen.dart';
import 'package:netflix/presentation/search_screen/search_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final pages = [
    HomeScreen( ),
    NewAndHotScreen(),
    FastLaughScreen(),
    SearchScreen(),
    DownloadScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, _) {
            return pages[index];
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
