import 'package:flutter/material.dart';
import 'package:game_rupiah/dompet_app.dart';
import 'package:game_rupiah/models/dompet.dart';

import 'daftar_uang_page.dart';
import 'index.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = DompetApp(dompet: Dompet([]));
        break;
      case 1:
        page = Index();
        break;
      case 2:
        page = DaftarUangPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    List menu = [
      Menu('Dompet'),
      Menu('Kuis'),
      Menu('Daftar Uang'),
    ];

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.wallet),
                        label: menu[0].title,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.quiz_outlined),
                        label: menu[1].title,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.list),
                        label: menu[2].title,
                      ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      if (value == selectedIndex) return;
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.quiz_outlined),
                        label: Text(menu[0].title),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.list),
                        label: Text(menu[1].title),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.list),
                        label: Text(menu[2].title),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      if (value == selectedIndex) return;
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}

class Menu {
  String title;
  Menu(this.title);
}
