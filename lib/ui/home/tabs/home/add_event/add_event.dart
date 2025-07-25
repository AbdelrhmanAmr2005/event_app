import 'package:assignment/firebase_utils.dart';
import 'package:assignment/model/event.dart';
import 'package:assignment/provider/event_list_provider.dart';
import 'package:assignment/ui/home/tabs/home/add_event/widget/date_or_time_widget.dart';
import 'package:assignment/ui/home/tabs/home/widget/event_tab_items.dart';
import 'package:assignment/ui/home/tabs/widgets/custom_elevated_button.dart';
import 'package:assignment/ui/home/tabs/widgets/custom_text_form_field.dart';
import 'package:assignment/utils/app_assets.dart';
import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/app_styles.dart';
import 'package:assignment/utils/toast_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String formatedTime = '';
  String selectedImage = '';
  String selectedEventName = '';
  late EventListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.workshop,
    ];
    List<String> imageSelectedEventList = [
      AppAssets.sportImage,
      AppAssets.birthdayImage,
      AppAssets.meetingImage,
      AppAssets.gamingImage,
      AppAssets.bookClubImage,
      AppAssets.exhibitionImage,
      AppAssets.holidayImage,
      AppAssets.eatingImage,
      AppAssets.workshopImage,
    ];
    // Map<String, String> eventsMapList = {
    //   AppLocalizations.of(context)!.sport: AppAssets.sportImage,
    //   AppLocalizations.of(context)!.birthday: AppAssets.birthdayImage,
    //   AppLocalizations.of(context)!.meeting: AppAssets.meetingImage,
    //   AppLocalizations.of(context)!.gaming: AppAssets.gamingImage,
    //   AppLocalizations.of(context)!.book_club: AppAssets.bookClubImage,
    //   AppLocalizations.of(context)!.exhibition: AppAssets.exhibitionImage,
    //   AppLocalizations.of(context)!.holiday: AppAssets.holidayImage,
    //   AppLocalizations.of(context)!.eating: AppAssets.eatingImage,
    //   AppLocalizations.of(context)!.workshop: AppAssets.workshopImage,
    // };
    selectedImage = imageSelectedEventList[selectedIndex];
    selectedEventName = eventsNameList[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: TextStyle(color: AppColors.primaryLight),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(imageSelectedEventList[selectedIndex]),
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                height: height * 0.03,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        selectedIndex = index;
                        setState(() {});
                      },
                      child: EventTabItems(
                        selectedTextStyle:
                            Theme.of(context).textTheme.headlineSmall,
                        unSelectedTextStyle:
                            Theme.of(context).textTheme.headlineMedium,
                        selectedBgColor: AppColors.primaryLight,
                        borderColor: AppColors.primaryLight,
                        isSelected: selectedIndex == index,
                        eventName: eventsNameList[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: width * 0.02);
                  },
                  itemCount: eventsNameList.length,
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                AppLocalizations.of(context)!.title,
                style: AppStyles.medium16Black.copyWith(
                  color: Theme.of(context).cardColor,
                ),
              ),
              SizedBox(height: height * 0.02),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      colorBorderSide: Theme.of(context).splashColor,
                      prefixIcon: Image.asset(
                        AppAssets.iconEdit,
                        color: Theme.of(context).canvasColor,
                      ),
                      controller: descriptionController,
                      hintText: AppLocalizations.of(context)!.event_title,
                      hintStyle: TextStyle(
                        color: Theme.of(context).canvasColor,
                      ),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_event_title;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.description,
                        style: AppStyles.medium16Black.copyWith(
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextFormField(
                      colorBorderSide: Theme.of(context).splashColor,
                      controller: titleController,
                      maxLines: 4,
                      hintText: AppLocalizations.of(context)!.event_description,
                      hintStyle: TextStyle(
                        color: Theme.of(context).canvasColor,
                      ),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_event_description;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    DateOrTimeWidget(
                      iconDateOrTimeName: AppAssets.iconDate,
                      eventDateOrTime: AppLocalizations.of(context)!.event_date,
                      chooseDateOrTime:
                          selectedDate == null
                              ? AppLocalizations.of(context)!.choose_date
                              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                      onChooseDateOrTimeClicked: chooseDate,
                    ),
                    DateOrTimeWidget(
                      iconDateOrTimeName: AppAssets.iconTime,
                      eventDateOrTime: AppLocalizations.of(context)!.event_time,
                      chooseDateOrTime:
                          selectedTime == null
                              ? AppLocalizations.of(context)!.choose_time
                              : formatedTime,
                      onChooseDateOrTimeClicked: chooseTime,
                    ),
                    SizedBox(height: height * 0.02),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.location,
                        style: AppStyles.medium16Black.copyWith(
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.01,
                        horizontal: width * 0.01,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primaryLight,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.02,
                              horizontal: width * 0.04,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.primaryLight,
                            ),
                            child: Image.asset(AppAssets.iconLocation),
                          ),
                          Text(
                            AppLocalizations.of(context)!.choose_event_location,
                            style: AppStyles.medium16Praimary,
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColors.primaryLight,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        onPressed: () {
                          addEvent();
                        },
                        text: AppLocalizations.of(context)!.add_event,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = chooseDate;
    if (selectedDate != null) {
      setState(() {});
    }
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    if (selectedTime != null) {
      formatedTime = selectedTime!.format(context);
      setState(() {});
    }
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      Event event = Event(
        dateTime: selectedDate!,
        description: descriptionController.text,
        eventName: selectedEventName,
        image: selectedImage,
        time: formatedTime,
        title: titleController.text,
      );
      FirebaseUtils.addEventsToFireStore(event).timeout(
        Duration(milliseconds: 500),
        onTimeout: () {
          ToastUtils.toastMsg(
            msg: "event added",
            backgroundColor: AppColors.primaryLight,
            textColor: AppColors.whiteColor,
          );
          eventListProvider.getAllEvents();
          Navigator.pop(context);
        },
      );
    }
  }
}