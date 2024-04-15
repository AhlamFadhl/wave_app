part of 'cubit.dart';

@immutable
abstract class SectionState {}

class SectionInitial extends SectionState {}

class SectionLoadingState extends SectionState {}

class SectionSucessState extends SectionState {}

class SectionErrorState extends SectionState {}
