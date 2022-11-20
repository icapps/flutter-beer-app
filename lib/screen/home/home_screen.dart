import 'package:flutter/material.dart';
import 'package:beer_app/navigator/route_names.dart';
import 'package:beer_app/screen/debug/debug_screen.dart';
import 'package:beer_app/screen/todo/todo_list/todo_list_screen.dart';
import 'package:beer_app/util/extension/localization_extension.dart';
import 'package:beer_app/widget/general/theme_widget.dart';
import 'package:beer_app/widget/provider/data_provider_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = RouteNames.homeScreen;

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ThemeWidget(
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            TodoListScreen(),
            DebugScreen(),
          ],
        ),
        bottomNavigationBar: DataProviderWidget(
          childBuilderTheme: (context, theme) => BottomNavigationBar(
            onTap: _onTap,
            currentIndex: _currentIndex,
            backgroundColor: theme.colorsTheme.bottomNavbarBackground,
            selectedItemColor: theme.colorsTheme.bottomNavbarItemActive,
            unselectedItemColor: theme.colorsTheme.bottomNavbarItemInactive,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.list),
                label: localization.todoTitle,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: localization.settingsTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(int newIndex) {
    setState(() => _currentIndex = newIndex);
  }
}
