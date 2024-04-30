import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wave_app/model/review.dart';
import 'package:wave_app/shared/components/custom_widgits/custom_button_widget.dart';
import 'package:wave_app/shared/components/custom_widgits/custom_text.dart';
import 'package:wave_app/shared/components/custom_widgits/custom_text_field.dart';
import 'package:wave_app/shared/components/images.dart';
import 'package:wave_app/shared/styles/colors.dart';
import 'package:wave_app/screens/review/cubit/cubit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wave_app/shared/utils/functions.dart';

class RatingAddPage extends StatelessWidget {
  const RatingAddPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewCubit, ReviewState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ReviewCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('تقييم'),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: const Offset(0, 2),
                      )
                    ]),
                    child: Column(
                      children: [
                        const CustomText(
                          'قيم مدى استفادتك من الإجابة',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RatingBar.builder(
                          initialRating: cubit.ratingValue as double,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 50,
                          glow: false,
                          maxRating: 5,
                          unratedColor: Colors.black38,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            cubit.ratingValue = rating.round();
                            print(rating);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      CustomText(
                        'ادخل اسمك',
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        '(اختياري)',
                        color: Colors.black38,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: cubit.nameReviewController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      CustomText(
                        'اكتب مراجعه عن تجربتك',
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        '(اختياري)',
                        color: Colors.black38,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: cubit.noteReviewController,
                    maxLines: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButtonWidget(
                      loading: cubit.isLoadingInsertRating,
                      title: 'ارسال',
                      onTap: () async {
                        if (cubit.ratingValue > 0) {
                          Review review = Review(
                              name: cubit.nameReviewController.text,
                              usr: 0,
                              rating: cubit.ratingValue,
                              note: cubit.noteReviewController.text,
                              datetime: DateTime.now().toString());
                          var result = await cubit.insertReviews(review);
                          if (result == 1) {
                            await showCustomDialog(context);
                            //  Get.back();
                          }
                        } else {
                          showToast(
                              text: 'الرجاء تقييم واحد من خمسه !',
                              state: ToastStates.WARNING);
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showCustomDialog(
    BuildContext context,
  ) async {
    showGeneralDialog(
      barrierLabel: "Barrier",
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return AlertDialog(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      'تم الارسال',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                iconsDone,
                fit: BoxFit.cover,
              ),
              const CustomText(
                'شكرا لتقيمك!',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                'شاكرين تفاعلك معنا',
                textAlign: TextAlign.center,
                color: textColor,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    ).whenComplete(() => context.pop());
  }
}
