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

//void main() => runApp(const NavigationRailExampleApp());

// class NavigationRailExampleApp extends StatelessWidget {
//   const NavigationRailExampleApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: NavRailExample());
//   }
// }

// class NavRailExample extends StatefulWidget {
//   const NavRailExample({super.key});

//   @override
//   State<NavRailExample> createState() => _NavRailExampleState();
// }

// class _NavRailExampleState extends State<NavRailExample> {
//   int _selectedIndex = 0;
//   NavigationRailLabelType labelType = NavigationRailLabelType.all;
//   bool showLeading = false;
//   bool showTrailing = false;
//   double groupAlignment = -1.0;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: Row(
  //         children: <Widget>[
  //           NavigationRail(
  //             selectedIndex: _selectedIndex,
  //             groupAlignment: groupAlignment,
  //             onDestinationSelected: (int index) {
  //               setState(() {
  //                 _selectedIndex = index;
  //               });
  //             },
            //   labelType: labelType,
            //   leading: showLeading
            //       ? FloatingActionButton(
            //           elevation: 0,
            //           onPressed: () {
            //             // Add your onPressed code here!
            //           },
            //           child: const Icon(Icons.add),
            //         )
            //       : const SizedBox(),
            //   trailing: showTrailing
            //       ? IconButton(
            //           onPressed: () {
            //             // Add your onPressed code here!
            //           },
            //           icon: const Icon(Icons.more_horiz_rounded),
            //         )
            //       : const SizedBox(),
            //   destinations: const <NavigationRailDestination>[
            //     NavigationRailDestination(
            //       icon: Icon(Icons.favorite_border),
            //       selectedIcon: Icon(Icons.favorite),
            //       label: Text('First'),
            //     ),
            //     NavigationRailDestination(
            //       icon: Badge(child: Icon(Icons.bookmark_border)),
            //       selectedIcon: Badge(child: Icon(Icons.book)),
            //       label: Text('Second'),
            //     ),
            //     NavigationRailDestination(
            //       icon: Badge(label: Text('4'), child: Icon(Icons.star_border)),
            //       selectedIcon: Badge(
            //         label: Text('4'),
            //         child: Icon(Icons.star),
            //       ),
            //       label: Text('Third'),
            //     ),
            //   ],
            // ),
//             const VerticalDivider(thickness: 1, width: 1),
//             // This is the main content.
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text('selectedIndex: $_selectedIndex'),
//                   const SizedBox(height: 20),
//                   Text('Label type: ${labelType.name}'),
//                   const SizedBox(height: 10),
//                   SegmentedButton<NavigationRailLabelType>(
//                     segments: const <ButtonSegment<NavigationRailLabelType>>[
//                       ButtonSegment<NavigationRailLabelType>(
//                         value: NavigationRailLabelType.none,
//                         label: Text('None'),
//                       ),
//                       ButtonSegment<NavigationRailLabelType>(
//                         value: NavigationRailLabelType.selected,
//                         label: Text('Selected'),
//                       ),
//                       ButtonSegment<NavigationRailLabelType>(
//                         value: NavigationRailLabelType.all,
//                         label: Text('All'),
//                       ),
//                     ],
//                     selected: <NavigationRailLabelType>{labelType},
//                     onSelectionChanged:
//                         (Set<NavigationRailLabelType> newSelection) {
//                           setState(() {
//                             labelType = newSelection.first;
//                           });
//                         },
//                   ),
//                   const SizedBox(height: 20),
//                   Text('Group alignment: $groupAlignment'),
//                   const SizedBox(height: 10),
//                   SegmentedButton<double>(
//                     segments: const <ButtonSegment<double>>[
//                       ButtonSegment<double>(value: -1.0, label: Text('Top')),
//                       ButtonSegment<double>(value: 0.0, label: Text('Center')),
//                       ButtonSegment<double>(value: 1.0, label: Text('Bottom')),
//                     ],
//                     selected: <double>{groupAlignment},
//                     onSelectionChanged: (Set<double> newSelection) {
//                       setState(() {
//                         groupAlignment = newSelection.first;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   SwitchListTile(
//                     title: Text(showLeading ? 'Hide Leading' : 'Show Leading'),
//                     value: showLeading,
//                     onChanged: (bool value) {
//                       setState(() {
//                         showLeading = value;
//                       });
//                     },
//                   ),
//                   SwitchListTile(
//                     title: Text(
//                       showTrailing ? 'Hide Trailing' : 'Show Trailing',
//                     ),
//                     value: showTrailing,
//                     onChanged: (bool value) {
//                       setState(() {
//                         showTrailing = value;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TaskListScreen extends StatefulWidget {
//   const TaskListScreen({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<TaskListScreen> createState() => _TaskListState();
// }

// class _TaskListState extends State<TaskListScreen> {
//   int _taskCounter = 0;

//   void _createTask() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _taskCounter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<String> titles = <String>['A', 'B', 'C'];
//     // This method is rerun every time setState is called, for instance as done
//     // by the _createTask method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take input value from App.build method, use it to set our appbar title
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center: layout widget, takes single child, positions it center of parent
//         child: Row(
//           crossAxisAlignment: .center,
//           mainAxisSize: .max,
//           mainAxisAlignment: .spaceEvenly,
//           children: <Widget>[
//             Expanded(
//               child: ListView.separated(
//                 padding: const EdgeInsets.all(8),
//                 itemCount: titles.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     height: 50,
//                     color: const Color.fromARGB(255, 114, 157, 255),
//                     child: Center(child: Text('Entry ${titles[index]}')),
//                   );
//                 },
//                 separatorBuilder: (BuildContext context, int index) => const Divider(),
//               )
//             ),
//             Expanded(
//               child: Column(
//                 children: [const Text('IN PROGRESS'),],
//               )
//             ),
//             Expanded(
//               child: Column(
//                 children: [const Text('FINALIZING'),],
//               )
//             ),
//             Expanded(
//               child: Column(
//                 children: [const Text('COMPLETED'),],
//               )
//             ),
//             const Text('You have created a task this many times:'),
//             Text(
//               '$_taskCounter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ]
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _createTask,
//         tooltip: 'New Task',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
