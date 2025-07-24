//import 'dart:async';
import 'package:assignment/firebase_utils.dart';
import 'package:assignment/model/event.dart';
import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/toast_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventList = [];
  List<Event> filterEventList = [];
  List<String> eventsNameList = [];
  List<Event> favoriteEventList = [];
  int selectedIndex = 0;
  List<String> getEventNameList(BuildContext context) {
    return eventsNameList = [
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
  }

  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventsCollection().get();
    eventList =
        querySnapshot.docs.map((doc) {
          return doc.data();
        }).toList();
    filterEventList = eventList;
    filterEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getFilterEvents() async {
    var querySnapshot = await FirebaseUtils.getEventsCollection().get();
    eventList =
        querySnapshot.docs.map((doc) {
          return doc.data();
        }).toList();
    filterEventList =
        eventList.where((event) {
          return event.eventName == eventsNameList[selectedIndex];
        }).toList();
    filterEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getFilterEventsFromFireStore() async {
    var querySnapshot =
        await FirebaseUtils.getEventsCollection()
            // .orderBy("event_date_time")
            .where('event_name', isEqualTo: eventsNameList[selectedIndex])
            .get();
    filterEventList =
        querySnapshot.docs.map((doc) {
          return doc.data();
        }).toList();
    notifyListeners();
  }

  void updateIsFavorite(Event event) {
    FirebaseUtils.getEventsCollection()
        .doc(event.id)
        .update({"is_favorite": !event.isFavorite})
        .timeout(
          Duration(milliseconds: 500),
          onTimeout: () {
            ToastUtils.toastMsg(
              msg: 'Event updated successfully',
              backgroundColor: AppColors.greenColor,
              textColor: AppColors.whiteColor,
            );
          },
        );
    selectedIndex == 0 ? getAllEvents() : getFilterEvents();
    getAllFavoriteEvents();
    notifyListeners();
  }

  void getAllFavoriteEvents() async {
    var querySnapshot = await FirebaseUtils.getEventsCollection().get();
    eventList =
        querySnapshot.docs.map((doc) {
          return doc.data();
        }).toList();
    favoriteEventList =
        eventList.where((event) {
          return event.isFavorite == true;
        }).toList();
    notifyListeners();
  }

  void getAllFavoriteEventsFromFireStore() async {
    var querySnapshot =
        await FirebaseUtils.getEventsCollection()
            .orderBy('event_date_time')
            .where('is_favorite', isEqualTo: true)
            .get();
    favoriteEventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
  }

  void changeSelectedIndex(int newSelectedIndex) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getAllEvents() : getFilterEvents();
    notifyListeners();
  }
}
