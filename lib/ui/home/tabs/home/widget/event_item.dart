import 'package:assignment/utils/app_assets.dart';
import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width*0.04
      ),
      height: height*0.31,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryLight,
          width: 2
        ),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(AppAssets.lamboBackground))
      ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: width*0.02,
            vertical: height*0.02
          ),
          padding: EdgeInsets.symmetric(
            horizontal: width*0.02
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.whiteColor
          ),
          child: Column(
            children: [
              Text('22',
              style: AppStyles.bold20Praimary,),
              Text('Nov',
              style: AppStyles.bold14Praimary,)
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.symmetric(
            horizontal: width*0.02,
            vertical: height*0.01
          ),
          padding: EdgeInsets.symmetric(
            horizontal: width*0.02,
            vertical: height*0.01
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.whiteColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text('This is a Birthday Party',
                style: AppStyles.bold14Black,),
              ),
              InkWell(
                onTap: (){
                },
                child: Image.asset(AppAssets.iconLoveUnSelected,
                color: AppColors.primaryLight,),
              )
            ],
          ),
        )
      ],
    ),
    );
  }
}