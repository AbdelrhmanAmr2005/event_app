import 'package:assignment/model/event.dart';
import 'package:assignment/provider/event_list_provider.dart';
import 'package:assignment/utils/app_assets.dart';
import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  Event event;
  EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      height: height * 0.31,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryLight, width: 2),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(event.image),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.02,
            ),
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor,
            ),
            child: Column(
              children: [
                Text(
                  event.dateTime.day.toString(),
                  style: AppStyles.bold20Praimary,
                ),
                Text(
                  DateFormat('MMM').format(event.dateTime),
                  style: AppStyles.bold14Praimary,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(event.title, style: AppStyles.bold14Black),
                ),
                InkWell(
                  onTap: () {
                    eventListProvider.updateIsFavorite(event);
                  },
                  child: event.isFavorite == true ? 
                  Image.asset(AppAssets.iconLoveSelected,
                  color: AppColors.primaryLight,)
                  :
                  Image.asset(
                    AppAssets.iconLoveUnSelected,
                    color: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
