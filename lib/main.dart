import 'package:flutter/material.dart';
import 'package:tomatodo/screens/task_list.dart';

void main() {
  runApp(const TomatodoApp());
}

// Hot reload:
// Run application
// Code changes
// Save changes or "hot reload" button or "r" in command line
// Without quitting the app
//
// Application state not lost during the reload
// Use hot restart to reset the state

class TomatodoApp extends StatelessWidget {
  const TomatodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomatodo',
      theme: ThemeData(
        // This is the theme of the application.
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 190, 235, 220),
        ),
        useMaterial3: true,
      ),
      home: NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<StatefulWidget> createState() => _NavBarState();
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Other screen')),
    );
  }
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [Test(), TaskList(), Test(), Test()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              groupAlignment: -1,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.account_circle_outlined),
                  selectedIcon: Icon(Icons.account_circle),
                  label: Text('Profile'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.assignment_outlined),
                  selectedIcon: Icon(Icons.assignment),
                  label: Text('Tasks'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.radio_outlined),
                  selectedIcon: Icon(Icons.radio),
                  label: Text('Music'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.school_outlined),
                  selectedIcon: Icon(Icons.school),
                  label: Text('Study'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: IndexedStack(index: _selectedIndex, children: _screens),
            ),
          ],
        ),
      ),
    );
  }
}
