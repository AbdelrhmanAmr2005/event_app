import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventTabItems extends StatelessWidget {
  bool isSelected;
  String eventName;
  EventTabItems({super.key, required this.isSelected, required this.eventName});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width*0.01
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width*0.02,
        vertical: height*0.001
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        border: Border.all(color: Theme.of(context).focusColor, width: 2),
              color:
          isSelected
              ? Theme.of(context).focusColor
              : AppColors.transparentColor,
      ),
      child: Text(eventName,
      style: isSelected? Theme.of(context).textTheme.headlineMedium
      : Theme.of(context).textTheme.headlineSmall,),

    );
  }
}
