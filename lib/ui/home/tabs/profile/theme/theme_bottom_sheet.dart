import 'package:assignment/provider/App_language_provider.dart';
import 'package:assignment/provider/App_theme_provider.dart';
import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.appTheme == ThemeMode.dark?
            getSelectedThemeItem(textTheme: AppLocalizations.of(context)!.dark):
            getUnSelectedThemeItem(textTheme: AppLocalizations.of(context)!.dark)
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.light);
            },
            child: themeProvider.appTheme == ThemeMode.light?
            getSelectedThemeItem(textTheme: AppLocalizations.of(context)!.light):
            getUnSelectedThemeItem(textTheme: AppLocalizations.of(context)!.light)
          ),
        ],
      ),
    );
  }

  Widget getSelectedThemeItem({required String textTheme}){
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(textTheme,
                  style: AppStyles.bold20Praimary,
                ),
                Icon(Icons.check, color: AppColors.primaryLight, size: 35),
              ],
    );
  }

  Widget getUnSelectedThemeItem({required String textTheme}){
    return Text(textTheme,
              style: AppStyles.bold20Black,
            );
  }
}
