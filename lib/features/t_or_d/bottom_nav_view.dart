import 'package:flutter/cupertino.dart';
import 'package:t_or_d/components/app_drawer_component.dart';
import 'package:t_or_d/features/t_or_d/bottom_nav_controller.dart';
import 'package:t_or_d/routes/exports.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (controller) {
        return Scaffold(
          // backgroundColor: Colors.white,

          /*appBar: AppBar(
            title: const AppText('Truth and Dare'),
            centerTitle: true,
          ),*/
          body: controller.children[controller.selectedIndex],
          drawer: drawer(
            context,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 20.0,
            selectedFontSize: 14.0,
            unselectedFontSize: 14.0,
            enableFeedback: true,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(
              color: AppColors.primaryColor,
            ),
            selectedIconTheme: IconThemeData(
              color: AppColors.primaryColor,
            ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.group),
                label: 'Play',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.rotate_left,
                ),
                label: 'Generate',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.info_circle,
                ),
                label: 'Play Online',
              ),
            ],
            currentIndex: controller.selectedIndex,
            selectedItemColor: AppColors.primaryColor,
            onTap: controller.onItemTapped,
          ),
        );
      },
    );
  }
}
