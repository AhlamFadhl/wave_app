part of 'cubit.dart';

@immutable
abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class AppLoadingRate extends ReviewState {}

class AppGetRate extends ReviewState {}
