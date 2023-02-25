import 'package:flutter/material.dart';
import 'package:ictu_mobile_app/app/app_controller.dart';
import 'package:ictu_mobile_app/app/app_routers.dart';
import 'package:ictu_mobile_app/app/app_styles.dart';
import 'package:provider/provider.dart';

import 'home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(context),
      builder: (context, _) {
        viewModel = context.read<HomeViewModel>();
        return Scaffold(
          body: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/app_logo_blue.png',
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: () {
                    AppController.instance.clearSession();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRouter.login,
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Đăng xuất',
                    style: $styles.text.styleInter.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
