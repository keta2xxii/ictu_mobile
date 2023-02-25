import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ictu_mobile_app/app/app_routers.dart';
import 'package:ictu_mobile_app/app/app_styles.dart';
import 'package:ictu_mobile_app/custom_widgets/extensions.dart';

import '../../generated/locale_keys.g.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouter.login,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/splash_bg.png',
          ),
          fit: BoxFit.fill,
        ),
        gradient: LinearGradient(
          colors: [
            $styles.colors.color0F79D,
            $styles.colors.color0059C3,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              children: [
                Text(
                  LocaleKeys.splash_learnOnline.tr(),
                  style: $styles.text.styleInter.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  'assets/images/app_logo.png',
                  height: 90,
                ),
                12.verticalSpace,
                Text(
                  LocaleKeys.splash_createdBy.tr(),
                  style: $styles.text.styleInter.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                60.verticalSpace,
                const Spacer(),
                Text(
                  LocaleKeys.splash_website.tr(),
                  style: $styles.text.styleInter.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
