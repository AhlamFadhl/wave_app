import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wave_app/lang/app_localization.dart';
import 'package:wave_app/screens/review/cubit/cubit.dart';
import 'package:wave_app/shared/components/components.dart';
import 'package:wave_app/shared/components/custom_widgits/custom_text.dart';
import 'package:wave_app/shared/components/custom_widgits/shimmer_list.dart';

class RatingDetails extends StatelessWidget {
  const RatingDetails({
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
            title: Text("Ratings".tra(context)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ConditionalBuilder(
                    condition: !cubit.isLoadingReviews,
                    fallback: (context) => const ShimmerList(),
                    builder: (context) => ConditionalBuilder(
                        condition: cubit.list_reviews.isNotEmpty,
                        fallback: (context) => SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star_rate_outlined,
                                    size: 40,
                                    color: Colors.black38,
                                  ),
                                  CustomText(
                                    'NoRating'.tra(context),
                                    color: Colors.black38,
                                  )
                                ],
                              ),
                            ),
                        builder: (context) {
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: cubit.list_reviews.length,
                            itemBuilder: (context, index) => buildReviewCard(
                              cubit.list_reviews[index],
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed('review_add');
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
