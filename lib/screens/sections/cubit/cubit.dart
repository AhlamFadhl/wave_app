import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wave_app/model/home.dart';
import 'package:wave_app/model/section.dart';
import 'package:wave_app/shared/components/constants.dart';
import 'package:wave_app/shared/utils/error_handler.dart';
import 'package:wave_app/shared/utils/functions.dart';
import 'package:wave_app/shared/network/end_points.dart';
import 'package:wave_app/shared/network/remote/dio_helper.dart';

part 'state.dart';

class SectionCubit extends Cubit<SectionState> {
  SectionCubit({required this.lstSection}) : super(SectionInitial());
  static SectionCubit get(context) => BlocProvider.of(context);

  bool isLoadingSection = false;
  bool isLoadingSelect = false;
  List<Section> lstSection = [];
  getSections() async {
    if (await checkInternet()) {
      isLoadingSection = true;
      lstSection = [];
      emit(SectionLoadingState());
      try {
        var value = await DioHelper.getData(
          url: SECTION,
          lang: langCode,
        );
        if (value.statusCode == 200) {
          List<dynamic> sections = value.data;
          lstSection = sections.map((e) => Section.fromJson(e)).toList();
          isLoadingSection = false;
          emit(SectionSucessState());
        } else {
          isLoadingSection = false;
          emit(SectionErrorState());
        }
      } catch (error) {
        ErrorHandler.handleError(error, showTost: true);
        print(error.toString());

        isLoadingSection = false;
        emit(SectionErrorState());
        showToast(text: 'تأكد من الانترنت', state: ToastStates.WARNING);
      }
    } else {
      showToast(text: 'تأكد من اتصالك بالانترنت', state: ToastStates.WARNING);
    }
  }

  getHome(Section section, BuildContext context) async {
    if (await checkInternet()) {
      isLoadingSelect = true;
      section.isLoading = true;
      emit(SectionLoadingState());
      try {
        var value = await DioHelper.getData(
          url: "$SECTION/${section.id}",
          lang: langCode,
        );
        if (value.statusCode == 200) {
          HomeModel hom = HomeModel.fromJson(value.data);
          // navigateAndFinish(context, MainLayout(sectionMain: section));
          context.goNamed('main', extra: {'sectionMain': section, 'home': hom});
          isLoadingSelect = false;
          section.isLoading = false;
          emit(SectionSucessState());
        } else {
          isLoadingSelect = false;
          section.isLoading = false;
          emit(SectionErrorState());
        }
      } catch (error) {
        ErrorHandler.handleError(error, showTost: true);
        print(error);
        isLoadingSelect = false;
        section.isLoading = false;
        emit(SectionErrorState());
        showToast(text: 'تأكد من الانترنت', state: ToastStates.WARNING);
      }
    } else {
      showToast(text: 'تأكد من اتصالك بالانترنت', state: ToastStates.WARNING);
    }
  }
}
