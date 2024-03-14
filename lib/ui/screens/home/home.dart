import 'package:flutter/material.dart';
import 'package:todo_mon_c10/ui/screens/home/tabs/list_tab/list_tab.dart';
import 'package:todo_mon_c10/ui/screens/home/tabs/settings/settings_tab.dart';
import 'package:todo_mon_c10/ui/utils/app_colors.dart';

import '../bottom_sheets/add_bottom_sheet/add_bottom_sheet.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTabIndex = 0;
  List<Widget> tabs = [
    ListTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To do List"),
      ),
      body: tabs[currentTabIndex],
      floatingActionButton: fab,
      bottomNavigationBar: mainBottomNavigation,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget get fab => FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(context: context,
              isScrollControlled: true,
              builder: (context){
              return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddBottomSheet(),
            );
          });
        },
        child: Icon(Icons.add),
        shape: const StadiumBorder(
            side: BorderSide(color: AppColors.white, width: 4)),
      );

  Widget get mainBottomNavigation => BottomAppBar(
    shape: CircularNotchedRectangle(),
    notchMargin: 12,
    clipBehavior: Clip.hardEdge,
    child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "list"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "settings"),
          ],
          onTap: (index) {
            currentTabIndex = index;
            setState(() {});
          },
          currentIndex: currentTabIndex,
        ),
  );
}
