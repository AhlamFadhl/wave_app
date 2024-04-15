part of 'cubit.dart';

@immutable
abstract class CenterState {}

class CenterInitial extends CenterState {}

class CenterLoadingState extends CenterState {}

class CenterSucessState extends CenterState {}

class CenterErrorState extends CenterState {}

class CenterDepartmentSelectState extends CenterState {}
