import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_app/lang/app_localization.dart';
import 'package:wave_app/lang/cubit/cubit.dart';
import 'package:wave_app/lang/cubit/state.dart';
import 'package:wave_app/model/section.dart';
import 'package:wave_app/screens/sections/cubit/cubit.dart';
import 'package:wave_app/shared/components/components.dart';
import 'package:wave_app/shared/components/constants.dart';
import 'package:wave_app/shared/components/custom_widgits/custom_text.dart';
import 'package:wave_app/shared/components/custom_widgits/shimmer_grid.dart';
import 'package:wave_app/shared/styles/colors.dart';

class SectionPage extends StatelessWidget {
  final List<Section> listSection;
  const SectionPage({super.key, required this.listSection});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SectionCubit(lstSection: listSection),
      child: BlocConsumer<SectionCubit, SectionState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SectionCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const Spacer(),
                  CustomText(
                    "LookingFor".tra(context),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  ConditionalBuilder(
                      condition: !cubit.isLoadingSection,
                      fallback: (context) => const ShimmerGrid(),
                      builder: (context) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(20),
                          shrinkWrap: true,
                          itemCount: cubit.lstSection.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // number of items in each row
                            mainAxisSpacing: 20.0, // spacing between rows
                            crossAxisSpacing: 20.0, // spacing between columns
                          ),
                          itemBuilder: (context, index) =>
                              buildSectionCard(cubit.lstSection[index], () {
                            if (!cubit.isLoadingSelect) {
                              cubit.getHome(cubit.lstSection[index], context);
                            }
                          }),
                        );
                      }),
                  const Spacer(),
                  SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: BlocConsumer<LocaleCubit, ChangeLocaleState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          var cubitLang = LocaleCubit.get(context);
                          return MaterialButton(
                            onPressed: () {
                              cubitLang.changeLanguage(
                                  langCode == 'en' ? 'ar' : 'en');
                              cubit.getSections();
                            },
                            child: CustomText(
                              "Lang".tra(context),
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
