import 'package:flutter/material.dart';
import 'package:quiz_app/core/extensions/string_extension.dart';
import 'package:quiz_app/core/util/navigator_helper.dart';
import 'package:quiz_app/resources/constants_manager.dart';

import '../../core/shared/components/background_image.dart';
import '../../resources/app_strings.dart';
import '../home_screen/presentation/home_screen.dart';

class ScoreScreen extends StatelessWidget {
  final String score;
  const ScoreScreen({required this.score, Key? key}) : super(key: key);
  static String routeName = 'score_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 3),
                Text(
                  AppStrings.score.tr(context),
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: ConstantsManager.kSecondaryColor),
                ),
                const Spacer(),
                Text(
                  score,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: ConstantsManager.kSecondaryColor),
                ),
                const Spacer(flex: 3),
                ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          ConstantsManager.kSecondaryColor),
                    ),
                    onPressed: () {
                      NavigatorHelper.pushReplacement(
                          context, const HomeScreen());
                    },
                    child: Text(
                      AppStrings.toHomeScreen.tr(context),
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleLarge?.fontSize),
                    )),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
