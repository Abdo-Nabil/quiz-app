import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/config/routes/app_routes.dart';
import 'package:quiz_app/resources/app_strings.dart';

import 'features/authentication/cubits/auth_cubit.dart';
import 'features/general/cubits/general_cubit.dart';
import 'features/home_screen/cubits/home_screen_cubit.dart';
import 'features/localization/locale/app_localizations_setup.dart';
import 'features/localization/presentation/cubits/localization_cubit.dart';
import 'features/quiz_screen/cubits/quiz_screen_cubit.dart';
import 'features/theme/app_theme.dart';
import 'features/theme/cubits/theme_cubit.dart';
import 'injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    // debugInvertOversizedImages = true;
    //

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<LocalizationCubit>()..getLocale()),
        BlocProvider(create: (context) => sl<ThemeCubit>()..getTheme()),
        BlocProvider(
            create: (context) => sl<GeneralCubit>()..getInitialScreen()),
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(create: (context) => sl<HomeScreenCubit>()),
        BlocProvider(create: (context) => sl<QuizScreenCubit>()),
      ],
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              //
              final Locale selectedLocale =
                  BlocProvider.of<LocalizationCubit>(context).selectedLocale;
              final ThemeMode selectedThemeMode =
                  BlocProvider.of<ThemeCubit>(context).selectedThemeMode;
              final Widget initialScreen =
                  BlocProvider.of<GeneralCubit>(context).selectedScreen;
              //
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRoutes.onGenerateRoute,
                title: AppStrings.appNameForRecentApp,
                theme: AppTheme.lightTheme(selectedLocale, context),
                darkTheme: AppTheme.darkTheme(selectedLocale, context),
                themeMode: ThemeMode.light,
                // onGenerateRoute: AppRoutes.onGenerateRoute,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                locale: selectedLocale,
                // // localeResolutionCallback:
                //     AppLocalizationsSetup.localeResolutionCallback,
                localizationsDelegates:
                    AppLocalizationsSetup.localizationsDelegates,
                home: initialScreen,
              );
            },
          );
        },
      ),
    );
  }
}
