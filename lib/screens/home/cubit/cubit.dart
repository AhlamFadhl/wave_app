import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wave_app/model/category.dart';
import 'package:wave_app/model/home.dart';
import 'package:wave_app/model/section.dart';
import 'package:wave_app/shared/components/constants.dart';
import 'package:wave_app/shared/network/end_points.dart';
import 'package:wave_app/shared/network/remote/dio_helper.dart';
import 'package:wave_app/shared/utils/error_handler.dart';
import 'package:wave_app/shared/utils/functions.dart';

part 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeModel, required this.sectionMain})
      : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  Section sectionMain;
  HomeModel homeModel;

  bool isLoading = false;

  getCategories(Categories cat) async {
    if (await checkInternet()) {
      homeModel.categories!.forEach((element) {
        element.current = false;
      });
      cat.current = true;
      isLoading = true;
      emit(CatLoadingState());
      try {
        var value = await DioHelper.getData(
          url: SECTION + "/" + sectionMain.id.toString(),
          query: {"category_id": cat.id},
          lang: langCode,
        );
        if (value.statusCode == 200) {
          homeModel = HomeModel.fromJson(value.data);

          isLoading = false;
          emit(CatSucessState());
        } else {
          cat.current = false;
          isLoading = false;
          emit(CatErrorState());
        }
      } catch (error) {
        cat.current = false;
        ErrorHandler.handleError(error, showTost: true);
        print(error);
        isLoading = false;
        emit(CatErrorState());
        showToast(text: 'تأكد من الانترنت', state: ToastStates.WARNING);
      }
    } else {
      showToast(text: 'تأكد من اتصالك بالانترنت', state: ToastStates.WARNING);
    }
  }
}
