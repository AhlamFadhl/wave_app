import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wave_app/lang/app_localization.dart';
import 'package:wave_app/screens/splash/cubit/cubit.dart';
import 'package:wave_app/shared/components/custom_widgits/custom_text.dart';
import 'package:wave_app/shared/components/images.dart';
import 'package:wave_app/shared/styles/colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocConsumer<SplashCubit, SplashStates>(
      listener: (context, state) {
        var cubit = SplashCubit.get(context);
        if (state is SplashSucessState) {
          context.goNamed('section', extra: {'section': cubit.lst});
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Center(
            child: (state is SplashNoInternetState)
                ? Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(iconInternet),
                        CustomText(
                          "noInternet".tra(context),
                          color: grayColor,
                        ),
                      ],
                    ),
                  )
                : ((state is SplashFailedState || state is SplashErrorState)
                    ? Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Image.asset(iconError),
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: double.infinity,
                        color: primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Image.asset(iconLogo_white),
                        ),
                      )),
          ),
        );
      },
    );
  }
}
