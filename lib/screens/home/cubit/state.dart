part of 'cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class CatLoadingState extends HomeState {}

class CatSucessState extends HomeState {}

class CatErrorState extends HomeState {}
