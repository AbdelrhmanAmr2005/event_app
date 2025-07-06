import 'package:assignment/ui/home/tabs/love/favorite_tab.dart';
import 'package:assignment/ui/home/tabs/map/map_tab.dart';
import 'package:assignment/ui/home/tabs/profile/profile_tab.dart';
import 'package:assignment/utils/app_assets.dart';
import 'package:assignment/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomeScreen(),MapTab(),FavoriteTab(),ProfileTab()
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        items: [
          builtBottomNavigationBarItem(
            index: 0,
            selectedIconName: AppAssets.iconHomeSelected,
            unSelectedIconName: AppAssets.iconHomeUnSelected,
            label: AppLocalizations.of(context)!.home,
          ),
          builtBottomNavigationBarItem(
            index: 1,
            selectedIconName: AppAssets.iconMapSelected,
            unSelectedIconName: AppAssets.iconMapUnSelected,
            label: AppLocalizations.of(context)!.map,
          ),
          builtBottomNavigationBarItem(
            index: 2,
            selectedIconName: AppAssets.iconLoveSelected,
            unSelectedIconName: AppAssets.iconLoveUnSelected,
            label: AppLocalizations.of(context)!.love,
          ),
          builtBottomNavigationBarItem(
            index: 3,
            selectedIconName: AppAssets.iconProfileSelcted,
            unSelectedIconName: AppAssets.iconProfileUnSelected,
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: AppColors.whiteColor, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  BottomNavigationBarItem builtBottomNavigationBarItem({
    required String selectedIconName,
    required String unSelectedIconName,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(
          selectedIndex == index ? selectedIconName : unSelectedIconName,
        ),
      ),
      label: label,
    );
  }
}
