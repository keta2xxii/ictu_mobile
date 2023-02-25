import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ictu_mobile_app/app/app_routers.dart';
import 'package:ictu_mobile_app/app/app_styles.dart';
import 'package:ictu_mobile_app/custom_widgets/custom_text_form_field.dart';
import 'package:ictu_mobile_app/custom_widgets/extensions.dart';
import 'package:ictu_mobile_app/modules/authentication/login_view_model.dart';
import 'package:ictu_mobile_app/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../../generated/locale_keys.g.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginViewModel viewModel;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(context),
      builder: (context, _) {
        viewModel = context.read<LoginViewModel>();
        return GestureDetector(
          onTap: () => Helpers.hideKeyboard(context),
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: ValueListenableBuilder(
                valueListenable: viewModel.userModel,
                builder: (context, value, child) => value != null
                    ? IconButton(
                        onPressed: () {
                          viewModel.userModel.value = null;
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 30,
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
            body: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 24,
                  right: 24,
                ),
                physics: const ClampingScrollPhysics(),
                children: [
                  ValueListenableBuilder(
                    valueListenable: viewModel.userModel,
                    builder: (context, userModel, _) {
                      return userModel != null
                          ? Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: SizedBox(
                                    child: CachedNetworkImage(
                                      imageUrl: userModel.avatar ?? '',
                                      errorWidget: (context, url, error) =>
                                          const ColoredBox(
                                        color: Colors.red,
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    userModel.displayName ?? '',
                                    style: $styles.text.styleInter.copyWith(
                                      color: $styles.colors.color2573E9,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 24,
                                  ),
                                  child: Text(
                                    'CTV Trung tâm GDTX Ninh Bình',
                                    style: $styles.text.styleInter.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Center(
                                  child: Image.asset(
                                    'assets/images/app_logo_blue.png',
                                    height: 70,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    LocaleKeys.common_companyName.tr(),
                                    style: $styles.text.styleInter.copyWith(
                                      color: $styles.colors.color2573E9,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                60.verticalSpace,
                                Center(
                                  child: Text(
                                    LocaleKeys.login_pleaseLoginStr.tr(),
                                    style: $styles.text.styleInter.copyWith(
                                      color: $styles.colors.color666E7A,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                20.verticalSpace,
                                SizedBox(
                                  child: CustomTextFormField(
                                    controller: usernameController,
                                    hintText: LocaleKeys.login_emailHint.tr(),
                                    validation: (p0) {
                                      if (p0 == null || p0.isEmpty) {
                                        return LocaleKeys.login_requiredField
                                            .tr(
                                          args: [
                                            LocaleKeys.login_emailHint.tr(),
                                          ],
                                        );
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                20.verticalSpace,
                              ],
                            );
                    },
                  ),
                  SizedBox(
                    child: CustomTextFormField(
                      obscureText: true,
                      controller: passwordController,
                      hintText: LocaleKeys.login_passwordHint.tr(),
                      validation: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return LocaleKeys.login_requiredField.tr(
                            args: [
                              LocaleKeys.login_passwordHint.tr(),
                            ],
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                  12.verticalSpace,
                  Text(
                    LocaleKeys.login_forgotPassStr.tr(),
                    style: $styles.text.styleInter.copyWith(
                      color: $styles.colors.color2573E9,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  24.verticalSpace,
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: $styles.colors.color3281FF,
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  viewModel.login(
                                    username: usernameController.text,
                                    password: passwordController.text,
                                    onSuccess: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRouter.mainView,
                                      );
                                    },
                                  );
                                }
                              },
                              child: Text(
                                LocaleKeys.login_loginStr.tr(),
                                style: $styles.text.styleInter.copyWith(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        30.horizontalSpace,
                        InkWell(
                          onTap: () {
                            viewModel.onTapLoginWithFaceID(
                              onSuccess: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.mainView,
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: $styles.colors.colorACCBEC,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Image.asset(
                              'assets/images/ic_face_id.png',
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  12.verticalSpace,
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: $styles.colors.colorFFB55C,
                        backgroundColor: $styles.colors.colorFFB55C,
                      ),
                      onPressed: () {},
                      child: Text(
                        LocaleKeys.login_loginWithICTUEmail.tr().toUpperCase(),
                        style: $styles.text.styleInter.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: $styles.colors.colorEEEEEE,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  LocaleKeys.login_helpStr.tr(),
                  style: $styles.text.styleInter.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
