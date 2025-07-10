import 'package:assignment/ui/home/tabs/home/widget/event_item.dart';
import 'package:assignment/ui/home/tabs/home/widget/event_tab_items.dart';
import 'package:assignment/utils/app_assets.dart';
import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: AppStyles.regular14White,
                ),
                Text('Route Academy', style: AppStyles.bold24White),
              ],
            ),
            Spacer(),
            ImageIcon(
              AssetImage(AppAssets.iconTheme),
              color: AppColors.whiteColor,
            ),
            Container(
              margin: EdgeInsets.only(left: width * 0.02),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Text('EN', style: AppStyles.bold14Praimary),
            ),
          ],
        ),
        bottom: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: height * 0.1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          title: Column(
            children: [
              Row(
                children: [
                  Image.asset(AppAssets.iconMapUnSelected),
                  SizedBox(width: width * 0.02),
                  Text('Cairo , Egypt', style: AppStyles.medium14White),
                ],
              ),
              SizedBox(height: height * 0.01),
              DefaultTabController(
                length: eventsNameList.length,
                child: TabBar(
                  labelPadding: EdgeInsets.all(4),
                  isScrollable: true,
                  indicatorColor: AppColors.transparentColor,
                  dividerColor: AppColors.transparentColor,
                  tabAlignment: TabAlignment.start,
                  onTap: (index) {
                    selectedIndex = index;
                    setState(() {});
                  },
                  tabs:
                      eventsNameList.map((eventName) {
                        return EventTabItems(
                          isSelected:
                              selectedIndex ==
                              eventsNameList.indexOf(eventName),
                          eventName: eventName,
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: height * 0.02),
              itemBuilder: (context, index) {
                return EventItem();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: height * 0.02);
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
