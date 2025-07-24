import 'package:assignment/provider/event_list_provider.dart';
import 'package:assignment/ui/home/tabs/home/widget/event_item.dart';
import 'package:assignment/ui/home/tabs/widgets/custom_text_form_field.dart';
import 'package:assignment/utils/app_assets.dart';
import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatefulWidget {
  FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  TextEditingController searchController = TextEditingController();
  late EventListProvider eventListProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    eventListProvider.getAllFavoriteEvents();
    },);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: CustomTextFormField(
              colorBorderSide: AppColors.primaryLight,
              hintText: AppLocalizations.of(context)!.search_event,
              hintStyle: AppStyles.bold14Praimary,
              prefixIcon: Image.asset(AppAssets.iconSearch),
              controller: searchController,
            ),
          ),
          Expanded(
            child: eventListProvider.favoriteEventList.isEmpty ? 
            Center(
              child: Text(AppLocalizations.of(context)!.no_favorite_events_found,
              style: AppStyles.bold20Black,),
            )
            : 
            ListView.separated(
              padding: EdgeInsets.only(top: height * 0.02),
              itemBuilder: (context, index) {
                return EventItem(
                  event: eventListProvider.favoriteEventList[index],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: height * 0.02);
              },
              itemCount: eventListProvider.favoriteEventList.length,
            ),
          ),
        ],
      ),
    );
  }
}
