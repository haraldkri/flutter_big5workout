import 'package:flutter/material.dart';
import 'package:flutter_big5workout/interface/screens/profile/profile_screen.dart';
import 'package:flutter_big5workout/interface/screens/statistic/statistic_screen.dart';
import 'package:flutter_big5workout/interface/screens/training/training_screen.dart';

class BottomNavigationItemConfig {
  final String title;
  final Icon icon;
  final Icon activeIcon;
  final Widget content;

  BottomNavigationItemConfig({
    required this.title,
    required this.icon,
    required this.activeIcon,
    required this.content,
  });
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final List<BottomNavigationItemConfig> navigationItems = [
    BottomNavigationItemConfig(
      title: "Training",
      icon: const Icon(Icons.local_fire_department_outlined),
      activeIcon: const Icon(Icons.local_fire_department_rounded),
      content: const TrainingScreen(),
    ),
    BottomNavigationItemConfig(
      title: "Statistic",
      icon: const Icon(Icons.analytics_outlined),
      activeIcon: const Icon(Icons.analytics_rounded),
      content: const StatisticScreen(),
    ),
    BottomNavigationItemConfig(
      title: "Profile",
      icon: const Icon(Icons.person_outlined),
      activeIcon: const Icon(Icons.person_rounded),
      content: const ProfileScreen(),
    ),
  ];

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    BottomNavigationItemConfig activeItemConfig = widget.navigationItems[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(activeItemConfig.title),
        automaticallyImplyLeading: false,
      ),
      body: activeItemConfig.content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: widget.navigationItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: item.icon,
                activeIcon: item.activeIcon,
                label: item.title,
              ),
            )
            .toList(),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
