import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_app/lang/app_localization.dart';
import 'package:wave_app/layout/cubit/cubit.dart';
import 'package:wave_app/model/home.dart';
import 'package:wave_app/model/section.dart';
import 'package:wave_app/screens/home/home_page.dart';
import 'package:wave_app/shared/styles/colors.dart';

class MainLayout extends StatelessWidget {
  final Section sectionMain;
  final HomeModel homeModel;
  const MainLayout(
      {super.key, required this.sectionMain, required this.homeModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context1) =>
          AppCubit(sectionMain: sectionMain)..setBottomNavigation(context),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.sectionMain.name!),
              leading:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            ),
            body: DoubleBackToCloseApp(
              snackBar: SnackBar(
                content: Text("back".tra(context)),
              ),
              child: HomePage(
                sectionMain: sectionMain,
                homeModel: homeModel,
              ),
            ),
            bottomNavigationBar: ConvexAppBar(
              style: TabStyle.fixedCircle,
              items: cubit.items,
              activeColor: primaryColor,
              initialActiveIndex: 0,
              backgroundColor: Colors.white,
              color: Colors.grey,
              onTap: (index) {},
            ),
          );
        },
      ),
    );
  }
}
