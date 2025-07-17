import 'package:assignment/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DateOrTimeWidget extends StatelessWidget {
  String iconDateOrTimeName;
  String eventDateOrTime;
  String chooseDateOrTime;
  VoidCallback onChooseDateOrTimeClicked;
  DateOrTimeWidget({
    super.key,
    required this.iconDateOrTimeName,
    required this.eventDateOrTime,
    required this.chooseDateOrTime,
    required this.onChooseDateOrTimeClicked,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image.asset(iconDateOrTimeName , color: Theme.of(context).canvasColor,),
        SizedBox(width: width*0.02,),
        Text(eventDateOrTime, style: AppStyles.medium16Black.copyWith(
          color: Theme.of(context).canvasColor
        ) ,),
        Spacer(),
        TextButton(
          onPressed: () {
            onChooseDateOrTimeClicked();
          },
          child: Text(chooseDateOrTime, style: AppStyles.medium16Praimary ,
          
          ),
        ),
      ],
    );
  }
}
