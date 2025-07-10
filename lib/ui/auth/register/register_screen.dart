import 'package:assignment/ui/home/tabs/widgets/custom_elevated_button.dart';
import 'package:assignment/ui/home/tabs/widgets/custom_text_form_field.dart';
import 'package:assignment/utils/app_assets.dart';
import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/app_routes.dart';
import 'package:assignment/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController(text: "abdo@gmail.com");

  TextEditingController passwordController = TextEditingController(text: "123456");

  TextEditingController rePasswordController = TextEditingController(text: "123456");

  TextEditingController nameController = TextEditingController(text: "abdo");

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.register,
          style: AppStyles.bold16Black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width*0.04
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.logoTop, height: height * 0.20),
              SizedBox(height: height * 0.02),
              Form(
                child: Column(
                  key: formKey,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.name,
                      prefixIcon: Image.asset(AppAssets.iconUserName),
                      controller: nameController,
                      keyBoardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "${AppLocalizations.of(context)!.please_enter_name}";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
          
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.email,
                      prefixIcon: Image.asset(AppAssets.iconEmail),
                      controller: emailController,
                      keyBoardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "${AppLocalizations.of(context)!.please_enter_email}";
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
                      hintText: AppLocalizations.of(context)!.password,
                      prefixIcon: Image.asset(AppAssets.iconPassword),
                      suffixIcon: Image.asset(AppAssets.iconShowPassword),
                      controller: passwordController,
                      keyBoardType: TextInputType.number,
                      obsecureText: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "${AppLocalizations.of(context)!.please_enter_password}";
                        }
                        if (text.length > 6) {
                          return AppLocalizations.of(
                            context,
                          )!.password_must_be_atleast_6char;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.re_password,
                      prefixIcon: Image.asset(AppAssets.iconPassword),
                      suffixIcon: Image.asset(AppAssets.iconShowPassword),
                      controller: rePasswordController,
                      keyBoardType: TextInputType.number,
                      obsecureText: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "${AppLocalizations.of(context)!.please_enter_re_password}";
                        }
                        if (text.length > 6) {
                          return AppLocalizations.of(
                            context,
                          )!.password_must_be_atleast_6char;
                        }
                        if (passwordController.text != text) {
                          return "${AppLocalizations.of(context)!.re_password_dosent_match}";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      onPressed: () {
                        register();
                      },
                      text: AppLocalizations.of(context)!.create_account,
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.already_have_account}?",
                          style: AppStyles.bold16Black,
                        ),
                        SizedBox(width: width * 0.02),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: AppStyles.bold16Praimary.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState?.validate() == true) {
          Navigator.of(
          context,
          ).pushReplacementNamed(AppRoutes.homeRouteName);
    }
  }
}
