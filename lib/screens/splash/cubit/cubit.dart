import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_app/model/section.dart';
import 'package:wave_app/shared/components/constants.dart';
import 'package:wave_app/shared/utils/error_handler.dart';
import 'package:wave_app/shared/utils/functions.dart';
import 'package:wave_app/shared/network/end_points.dart';
import 'package:wave_app/shared/network/remote/dio_helper.dart';

part 'state.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitial());
  static SplashCubit get(context) => BlocProvider.of(context);

  List<Section> lst = [];
  getSections() async {
    lst = [];
    emit(SplashLoadingState());
    if (await checkInternet()) {
      try {
        var value = await DioHelper.getData(
          url: SECTION,
          lang: langCode,
        );
        if (value.statusCode == 200) {
          List<dynamic> sections = value.data;
          lst = sections.map((e) => Section.fromJson(e)).toList();
          emit(SplashSucessState());
        } else {
          emit(SplashFailedState());
        }
      } catch (error) {
        ErrorHandler.handleError(error, showTost: true);
        print(error);
        emit(SplashFailedState());
      }
    } else {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        emit(SplashNoInternetState());
      });
    }
  }
}
