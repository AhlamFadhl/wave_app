import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wave_app/lang/app_localization.dart';
import 'package:wave_app/lang/cubit/cubit.dart';
import 'package:wave_app/lang/cubit/state.dart';
import 'package:wave_app/screens/splash/cubit/cubit.dart';
import 'package:wave_app/shared/network/local/cache_helper.dart';
import 'package:wave_app/shared/network/remote/dio_helper.dart';
import 'package:wave_app/shared/styles/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wave_app/shared/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()..getSavedLanguage()),
        BlocProvider(create: (context) => SplashCubit()..getSections()),
      ],
      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        // listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(builder: (context, child) {
            return MaterialApp.router(
              routerConfig: router,
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              locale: state.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en'), Locale('ar')],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (deviceLocale != null &&
                      deviceLocale.languageCode == locale.languageCode) {
                    return deviceLocale;
                  }
                }

                return supportedLocales.first;
              },
            );
          });
        },
      ),
    );
  }
}
