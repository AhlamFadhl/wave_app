import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wave_app/lang/app_localization.dart';
import 'package:wave_app/model/home.dart';
import 'package:wave_app/model/section.dart';
import 'package:wave_app/screens/home/cubit/cubit.dart';
import 'package:wave_app/shared/components/components.dart';
import 'package:wave_app/shared/components/custom_widgits/custom_text.dart';
import 'package:wave_app/shared/styles/colors.dart';

class HomePage extends StatelessWidget {
  final Section sectionMain;
  final HomeModel homeModel;
  const HomePage(
      {super.key, required this.sectionMain, required this.homeModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(sectionMain: sectionMain, homeModel: homeModel),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Slider
                if (cubit.homeModel.sliders != null)
                  buildSliders(cubit.homeModel.sliders!),
                // End Slider

                //categories
                if (cubit.homeModel.categories != null)
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: SizedBox(
                      height: 100,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InkWell(
                                splashColor: primaryColor.withOpacity(0.5),
                                onTap: () {
                                  if (!cubit.isLoading &&
                                      !(cubit.homeModel.categories![index]
                                              .current ??
                                          false)) {
                                    cubit.getCategories(
                                        cubit.homeModel.categories![index]);
                                  }
                                },
                                child: buildCategoryCard(
                                    cubit.homeModel.categories![index]),
                              ),
                          separatorBuilder: (context, index) => Container(
                                height: 10,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: VerticalDivider(
                                  width: 2,
                                  thickness: 2,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                          itemCount: cubit.homeModel.categories!.length),
                    ),
                  ),
                //End categories

                //Recommended
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomText(
                    'Recommended'.tra(context),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 270,
                  child: setShimmer(
                    cubit.isLoading,
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              context.pushNamed('center', extra: {
                                "currentStore":
                                    cubit.homeModel.recommend![index]
                              });
                            },
                            child: buildStoreCard(
                                cubit.homeModel.recommend![index], () {
                              context.pushNamed('review');
                            })),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 20,
                            ),
                        itemCount: cubit.homeModel.recommend!.length),
                  ),
                ),
                //End Recommended

                //Stores
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        'Stores'.tra(context),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                primaryColor.withOpacity(0.2)),
                          ),
                          onPressed: () {},
                          child: Text(
                            'All'.tra(context),
                            style: const TextStyle(
                                color: primaryColor, fontSize: 16),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 270,
                  child: setShimmer(
                    cubit.isLoading,
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              context.pushNamed('center', extra: {
                                "currentStore": cubit.homeModel.stores![index]
                              });
                            },
                            child: buildStoreCard(
                                cubit.homeModel.stores![index], () {
                              context.pushNamed('review');
                            })),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 20,
                            ),
                        itemCount: cubit.homeModel.stores!.length),
                  ),
                ),

                //End Stores
              ],
            ),
          );
        },
      ),
    );
  }
}
