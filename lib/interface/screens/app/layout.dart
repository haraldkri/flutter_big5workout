import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppLayout(this.navigationShell, {super.key});

  void _goBranch(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Scaffold(
              body: navigationShell,
              bottomNavigationBar: BottomNavigationBar(
                key:const Key("bottom-nav-bar"),
                onTap: _goBranch,
                currentIndex: navigationShell.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                      key: Key("nav-item-training"),
                      icon: Icon(Icons.local_fire_department_outlined),
                      activeIcon: Icon(Icons.local_fire_department_rounded),
                      label: "Training"),
                  BottomNavigationBarItem(
                      key: Key("nav-item-statistic"),
                      icon: Icon(Icons.analytics_outlined),
                      activeIcon: Icon(Icons.analytics_rounded),
                      label: "Statistic"),
                  BottomNavigationBarItem(
                      key: Key("nav-item-profile"),
                      icon: Icon(Icons.person_outlined),
                      activeIcon: Icon(Icons.person_rounded),
                      label: "Training"),
                ],
              ),
            ));
  }
}
