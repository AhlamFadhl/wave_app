import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_app/model/store.dart';
import 'package:wave_app/shared/components/constants.dart';
import 'package:wave_app/shared/network/end_points.dart';
import 'package:wave_app/shared/network/remote/dio_helper.dart';
import 'package:wave_app/shared/utils/error_handler.dart';
import 'package:wave_app/shared/utils/functions.dart';

part 'state.dart';

class CenterCubit extends Cubit<CenterState> {
  CenterCubit({required this.store}) : super(CenterInitial());
  static CenterCubit get(context) => BlocProvider.of(context);

  var key = GlobalKey<ScaffoldState>();
  Store store;
  bool isLoading = false;
  List<Services> servicesAll = [];
  getAllDataStore() async {
    if (await checkInternet()) {
      isLoading = true;
      emit(CenterLoadingState());
      try {
        var value = await DioHelper.getData(
          url: "$STORE/${(store.slug ?? '')}",
          lang: langCode,
        );
        if (value.statusCode == 200) {
          store = Store.fromJson(value.data);
          if (store.services != null) servicesAll = store.services!;
          isLoading = false;
          emit(CenterSucessState());
        } else {
          isLoading = false;
          emit(CenterErrorState());
        }
      } catch (error) {
        ErrorHandler.handleError(error, showTost: true);
        print(error);
        isLoading = false;
        emit(CenterErrorState());
        showToast(text: 'تأكد من الانترنت', state: ToastStates.WARNING);
      }
    } else {
      showToast(text: 'تأكد من اتصالك بالانترنت', state: ToastStates.WARNING);
    }
  }

  getServiceDep(int id) {
    store.services = servicesAll
        .where((element) => element.groupsIds!.contains(id))
        .toList();
    emit(CenterDepartmentSelectState());
  }
}
