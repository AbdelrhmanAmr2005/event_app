import 'package:assignment/ui/home/tabs/widgets/custom_elevated_button.dart';
import 'package:assignment/ui/home/tabs/widgets/custom_text_form_field.dart';
import 'package:assignment/utils/app_assets.dart';
import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/app_routes.dart';
import 'package:assignment/utils/app_styles.dart';
import 'package:assignment/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(
    text: "abdo@gmail.com",
  );

  TextEditingController passwordController = TextEditingController(
    text: "123456",
  );

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AppAssets.logoTop, height: height * 0.20),
                SizedBox(height: height * 0.02),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        colorBorderSide: Theme.of(context).splashColor,
                        hintText: AppLocalizations.of(context)!.email,
                        hintStyle: TextStyle(
                          color: Theme.of(context).canvasColor,
                        ),
                        prefixIcon: Image.asset(
                          AppAssets.iconEmail,
                          color: Theme.of(context).canvasColor,
                        ),
                        controller: emailController,
                        keyBoardType: TextInputType.emailAddress,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.please_enter_email;
                          }
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(text.trim());
                          if (!emailValid) {
                            return AppLocalizations.of(
                              context,
                            )!.please_enter_valid_email;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      CustomTextFormField(
                        colorBorderSide: Theme.of(context).splashColor,
                        hintText: AppLocalizations.of(context)!.password,
                        hintStyle: TextStyle(
                          color: Theme.of(context).canvasColor,
                        ),
                        prefixIcon: Image.asset(
                          AppAssets.iconPassword,
                          color: Theme.of(context).canvasColor,
                        ),
                        suffixIcon: Image.asset(
                          AppAssets.iconShowPassword,
                          color: Theme.of(context).canvasColor,
                        ),
                        controller: passwordController,
                        keyBoardType: TextInputType.number,
                        obsecureText: true,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.please_enter_password;
                          } else if (text.length < 6) {
                            return AppLocalizations.of(
                              context,
                            )!.password_must_be_atleast_6char;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "${AppLocalizations.of(context)!.forget_password}?",
                              style: AppStyles.bold16Praimary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      CustomElevatedButton(
                        onPressed: () {
                          login();
                        },
                        text: AppLocalizations.of(context)!.login,
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.do_not_have_an_account}?",
                            style: AppStyles.bold16Black.copyWith(
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(
                                AppRoutes.registerRouteName,
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.create_account,
                              style: AppStyles.bold16Praimary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              indent: width * 0.10,
                              endIndent: width * 0.04,
                              color: AppColors.primaryLight,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.or,
                            style: AppStyles.medium16Praimary,
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              indent: width * 0.04,
                              endIndent: width * 0.10,
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      CustomElevatedButton(
                        mainAxisAlignment: MainAxisAlignment.center,
                        backgroundColor: AppColors.transparentColor,
                        textStyle: AppStyles.medium16Praimary,
                        icon: true,
                        iconWidget: Image.asset(AppAssets.iconGoogle),
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(AppRoutes.homeRouteName);
                        },
                        text: AppLocalizations.of(context)!.login_with_google,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      DialogUtils.showLoading(context: context);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMassage(
          context: context,
          message: "Login successfully",
          posActionName: "Ok",
          posAction: () {
            Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
          },
        );
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMassage(
          context: context,
          message: "$e",
          posActionName: "Ok",
          posAction: () {
            Navigator.pop(context);
          },
        );
      }
    }
  }
}
