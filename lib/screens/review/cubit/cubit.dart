import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_app/model/review.dart';
import 'package:wave_app/shared/network/end_points.dart';
import 'package:wave_app/shared/network/remote/dio_helper.dart';
import 'package:wave_app/shared/utils/error_handler.dart';

part 'state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());
  static ReviewCubit get(context) => BlocProvider.of(context);

  bool isLoadingInsertRating = false;
  var noteReviewController = TextEditingController();
  var nameReviewController = TextEditingController();
  int ratingValue = 0;
  Future<int> insertReviews(Review review) async {
    int status = 0;
    try {
      isLoadingInsertRating = true;
      emit(AppLoadingRate());
      var response =
          await DioHelper.postData(url: REVIEW_NEW, data: review.toJson());
      if (response.statusCode == 200) {
        status = response.data['status'];
        if (response.data['status'] == 1) {}
      }
    } catch (e) {
      ErrorHandler.handleError(e);
    }

    isLoadingInsertRating = false;
    emit(AppGetRate());
    return status;
  }

  ///List
  List<Review> list_reviews = [];
  bool isLoadingReviews = false;
  int skip = 0;
  Future<void> getReviewsDetails() async {
    try {
      list_reviews = [];
      isLoadingReviews = true;
      emit(AppLoadingRate());
      var response = await DioHelper.postData(url: REVIEWS_GET_ALL, data: {
        'skip': skip,
        'limit': 100,
      });
      if (response.statusCode == 200) {
        list_reviews = (response.data as List<dynamic>)
            .map((e) => Review.fromJson(e))
            .toList();
      }
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoadingReviews = false;
    emit(AppGetRate());
  }
}
