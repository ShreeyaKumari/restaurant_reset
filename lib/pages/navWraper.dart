import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:restaurant_app/pages/HomePage.dart';
// import 'package:restaurant_app/pages/about.dart';
import 'package:restaurant_app/pages/acceuil.dart';
import 'package:restaurant_app/utils/colors.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0); // Default tab index
  }

  // Screens for each tab
  List<Widget> _buildScreens() {
    return [
      HomePage(),
      // AboutPage(),
      Acceuil(
        name: "The Golden Fork", // Translated from "La fourchette d’or"
        addresse: "RVCE mingos", // Translated from "Faculté des sciences"
        desc: "A warm restaurant offering refined local and international cuisine.", // Translated
        telephone: "212 6 00 00 00 00", // Phone number
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Navigation bar items
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home, color: Theme.of(context).colorScheme.secondary),
          title: ("Home"), // Translated from "Accueil"
          activeColorPrimary: Theme.of(context).colorScheme.primary,
          inactiveColorPrimary: Colors.grey,
          activeColorSecondary: AppColors.primary,
        ),
        // PersistentBottomNavBarItem(
        //   icon: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.secondary),
        //   title: ("About"), // Translated from "À propos"
        //   activeColorPrimary: Theme.of(context).colorScheme.primary,
        //   inactiveColorPrimary: Colors.grey,
        //   activeColorSecondary: AppColors.primary,
        // ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.restaurant_menu, color: Theme.of(context).colorScheme.secondary),
          title: ("Restaurant"),
          activeColorPrimary: Theme.of(context).colorScheme.primary,
          inactiveColorPrimary: Colors.grey,
          activeColorSecondary: AppColors.primary,
        ),
      ];
    }

    // Final return of the navigation wrapper with tab view
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Theme.of(context).colorScheme.background,
      navBarStyle: NavBarStyle.style7,
      decoration: NavBarDecoration(
        useBackdropFilter: true,
        borderRadius: BorderRadius.circular(20),
        colorBehindNavBar: Theme.of(context).colorScheme.background,
      ),
      confineToSafeArea: true,
    );
  }
}
