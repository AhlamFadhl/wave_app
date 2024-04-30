import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_app/lang/app_localization.dart';
import 'package:wave_app/model/section.dart';
import 'package:wave_app/shared/components/images.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
part 'state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required this.sectionMain}) : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  Section sectionMain;
  List<String> titles = [];
  List<TabItem> items = [];

  setBottomNavigation(context) {
    titles = [
      'Home'.tra(context),
      'Alert'.tra(context),
      'Wave'.tra(context),
      'Cart'.tra(context),
      'Booking'.tra(context)
    ];
    items = [
      TabItem(icon: Icons.home, title: titles[0]),
      TabItem(icon: Icons.notifications, title: titles[1]),
      TabItem(
          icon: CircleAvatar(
            backgroundColor: Colors.grey.shade100,
            radius: 30,
            child: Image.asset(
              iconLogo,
              width: 40,
              height: 40,
            ),
          ),
          title: titles[2]),
      TabItem(icon: Icons.shopping_cart, title: titles[3]),
      TabItem(icon: Icons.shopping_bag_rounded, title: titles[4]),
    ];
  }
}
