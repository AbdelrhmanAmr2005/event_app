import 'package:assignment/provider/App_language_provider.dart';
import 'package:assignment/provider/App_theme_provider.dart';
import 'package:assignment/ui/auth/login/login_screen.dart';
import 'package:assignment/ui/auth/register/register_screen.dart';
import 'package:assignment/ui/home/home_screen.dart';
import 'package:assignment/ui/home/tabs/home/add_event/add_event.dart';
import 'package:assignment/utils/app_routes.dart';
import 'package:assignment/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppLanguageProvider(),),
      ChangeNotifierProvider(create: (context) => AppThemeProvider(),)
  ],
      child:  MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: AppRoutes.homeRouteName,
      routes: {
        AppRoutes.homeRouteName : (context) => HomeScreen(),
        AppRoutes.loginRouteName : (context) => LoginScreen(),
        AppRoutes.registerRouteName : (context) => RegisterScreen(),
        AppRoutes.addEventRouteName : (context) => AddEvent(),

      },
      locale: Locale(languageProvider.appLanguage),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}
