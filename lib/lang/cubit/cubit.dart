import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_app/lang/cubit/state.dart';
import 'package:wave_app/shared/components/constants.dart';
import 'package:wave_app/shared/network/local/cache_helper.dart';

class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: Locale('en')));
  static LocaleCubit get(context) => BlocProvider.of(context);
  Future<void> getSavedLanguage() async {
    langCode = await CacheHelper.getCachedLanguageCode() ?? "en";

    emit(ChangeLocaleState(locale: Locale(langCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    langCode = languageCode;
    await CacheHelper.cacheLanguageCode(langCode);
    emit(ChangeLocaleState(locale: Locale(langCode)));
  }
}
