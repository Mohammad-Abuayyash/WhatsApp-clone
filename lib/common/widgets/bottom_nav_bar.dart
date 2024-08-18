import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: AppColors.greyBackground,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle:
            const TextStyle(fontSize: 10, color: AppColors.greyDark),
        unselectedLabelStyle:
            const TextStyle(fontSize: 10, color: AppColors.greyDark),
        unselectedItemColor: Colors.white, //<-- add this
        fixedColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.update,
              color: AppColors.greyDark,
            ),
            label: 'Updates',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.call_sharp,
              color: AppColors.greyDark,
            ),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_outline,
              color: AppColors.greyDark,
            ),
            label: 'Communities',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: AppColors.greyDark,
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
              color: AppColors.greyDark,
            ),
            label: 'Settings',
          ),
        ]);
  }
}
