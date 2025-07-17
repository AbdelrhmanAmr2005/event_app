import 'package:assignment/provider/App_language_provider.dart';
import 'package:assignment/provider/App_theme_provider.dart';
import 'package:assignment/ui/home/tabs/profile/language/language_bottom_sheet.dart';
import 'package:assignment/ui/home/tabs/profile/theme/theme_bottom_sheet.dart';
import 'package:assignment/ui/home/tabs/widgets/custom_elevated_button.dart';
import 'package:assignment/utils/app_assets.dart';
import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/app_routes.dart';
import 'package:assignment/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: height * 0.18,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45)),
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: height * 0.01),
          child: Row(
            children: [
              Image.asset(AppAssets.routeImage),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Route Academy', style: AppStyles.bold24White),
                    Text(
                      'routeacademy@gmail.com',
                      style: AppStyles.medium16White,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              languageProvider.appLanguage == 'en'
                  ? AppLocalizations.of(context)!.language
                  : AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.02),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryLight, width: 2),
              ),
              child: InkWell(
                onTap: () {
                  showLanguageBottomSheet(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageProvider.appLanguage == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: AppStyles.bold20Praimary,
                    ),
                    Icon(
                      Icons.arrow_drop_up_outlined,
                      size: 35,
                      color: AppColors.primaryLight,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              languageProvider.appLanguage == 'en'
                  ? AppLocalizations.of(context)!.theme
                  : AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.02),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryLight, width: 2),
              ),
              child: InkWell(
                onTap: () {
                  showThemeBottomSheet(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.appTheme == ThemeMode.dark
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
                      style: AppStyles.bold20Praimary,
                    ),
                    Icon(
                      Icons.arrow_drop_up_outlined,
                      size: 35,
                      color: AppColors.primaryLight,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            CustomElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.loginRouteName);
              },
              backgroundColor: AppColors.redColor,
              borderColor: AppColors.redColor,
              icon: true,
              iconWidget: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Icon(
                  Icons.logout,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
              text: AppLocalizations.of(context)!.logout,
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}
