import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:go_router/go_router.dart';
import 'package:wave_app/lang/app_localization.dart';
import 'package:wave_app/model/store.dart';
import 'package:wave_app/screens/center/cubit/cubit.dart';
import 'package:wave_app/shared/components/components.dart';
import 'package:wave_app/shared/components/custom_widgits/custom_image.dart';
import 'package:wave_app/shared/components/custom_widgits/custom_text.dart';
import 'package:wave_app/shared/components/custom_widgits/shimmer_grid.dart';
import 'package:wave_app/shared/styles/colors.dart';

class CenterPage extends StatelessWidget {
  final Store currentStore;
  const CenterPage({super.key, required this.currentStore});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CenterCubit(store: currentStore)..getAllDataStore(),
      child: BlocConsumer<CenterCubit, CenterState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CenterCubit.get(context);
          return Scaffold(
            key: cubit.key,
            body: SafeArea(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: Stack(
                        children: [
                          setShimmer(
                            cubit.isLoading,
                            child: buildSliders(cubit.store.banners,
                                autoPlay: false, viewportFraction: 1),
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Container(
                              height: 35,
                              width: 35,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.chevron_left_rounded,
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 0,
                            end: MediaQuery.of(context).size.width * 0.5 - 50,
                            child: setShimmer(
                              cubit.isLoading,
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: cubit.isLoading
                                              ? baseColor
                                              : primaryColor,
                                          spreadRadius: 0.5)
                                    ]),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: CustomImage(
                                  url: cubit.store.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 60,
                            end: 20,
                            child: setShimmer(
                              cubit.isLoading,
                              child: InkWell(
                                onTap: cubit.isLoading
                                    ? null
                                    : () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) => Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight:
                                                      Radius.circular(16)),
                                            ),
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4) +
                                                20,
                                            alignment: Alignment.center,
                                            child: ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  if (index == 0) {
                                                    return buildSocialIcon(
                                                        Socials(
                                                            link: cubit
                                                                .store.mobile,
                                                            name: "phone",
                                                            icon: null),
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                4) -
                                                            20);
                                                  } else {
                                                    return buildSocialIcon(
                                                        cubit.store.socials![
                                                            index - 1],
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                4) -
                                                            20);
                                                  }
                                                },
                                                separatorBuilder:
                                                    (context, index) =>
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                itemCount: cubit
                                                        .store.socials!.length +
                                                    1),
                                          ),
                                        );
                                      },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: secondColor,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: CustomText(
                                    'contact'.tra(context),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: setShimmer(
                            cubit.isLoading,
                            child: Column(
                              children: [
                                CustomText(
                                  cubit.store.name,
                                  fontWeight: FontWeight.bold,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                ),
                                if (cubit.store.review != null)
                                  buidRateStart(0.0),
                              ],
                            ),
                          ),
                        ),
                        setShimmer(
                          cubit.isLoading,
                          child: IconButton(
                              onPressed: cubit.isLoading ? null : () {},
                              icon: Icon((cubit.store.hasFavorite ?? false)
                                  ? Icons.favorite
                                  : Icons.favorite_border)),
                        ),
                      ],
                    ),

                    //Tabs
                    setShimmer(
                      cubit.isLoading,
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: AppBar(
                          backgroundColor: Colors.grey.shade100,
                          bottom: TabBar(
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: primaryColor,
                            labelColor: primaryColor,
                            tabs: [
                              Tab(
                                text: 'Service'.tra(context),
                              ),
                              Tab(
                                text: 'About'.tra(context),
                              ),
                              Tab(
                                text: 'Branch'.tra(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 390,
                        child: TabBarView(children: [
                          //Service
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Departments
                                if (cubit.store.departments != null)
                                  SizedBox(
                                    height: 230,
                                    child: ListView.separated(
                                      padding: const EdgeInsets.all(20),
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          cubit.store.departments!.length,
                                      itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          for (var element
                                              in cubit.store.departments!) {
                                            element.isSelected = false;
                                          }
                                          cubit.store.departments![index]
                                              .isSelected = true;
                                          cubit.getServiceDep(cubit
                                              .store.departments![index].id!);
                                        },
                                        child: buildDepartment(
                                            cubit.store.departments![index]),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        width: 14,
                                      ),
                                    ),
                                  ),
                                if (cubit.isLoading)
                                  const ShimmerGrid(
                                    itemCount: 3,
                                    crossAxisCount: 3,
                                  ),
                                setShimmer(
                                  cubit.isLoading,
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 20),
                                    child: CustomText(
                                      'ServiceList'.tra(context),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                if (cubit.isLoading)
                                  const ShimmerGrid(
                                    itemCount: 2,
                                  ),
                                //Services
                                if (cubit.store.services != null)
                                  GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          2, // number of items in each row
                                      mainAxisSpacing:
                                          20, // spacing between rows
                                      crossAxisSpacing:
                                          20, // spacing between columns
                                    ),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cubit.store.services!.length,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    itemBuilder: (context, index) =>
                                        buidServiceCard(
                                            cubit.store.services![index],
                                            onTapInfo: () {
                                      showCustomDialog(context,
                                          cubit.store.services![index]);
                                    }),
                                  ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          //About Us
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: SingleChildScrollView(
                                child: HtmlWidget(
                              cubit.store.detail ?? '',
                              textStyle: const TextStyle(fontSize: 12),
                            )),
                          ),

                          //Branches
                          Container(
                            child: cubit.store.branches != null
                                ? ListView.separated(
                                    itemBuilder: (context, index) => Container(
                                          decoration: BoxDecoration(
                                              color: lightColor,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          padding: const EdgeInsets.all(8),
                                          margin: const EdgeInsets.all(20),
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.place,
                                              size: 50,
                                              color: Colors.grey.shade800,
                                            ),
                                            title: CustomText(
                                              cubit.store.branches![index].name,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                            subtitle: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: CustomText(
                                                cubit.store.branches![index]
                                                    .address,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade800,
                                                fontSize: 12,
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.chevron_right_rounded,
                                              size: 35,
                                              color: Colors.grey.shade800,
                                            ),
                                          ),
                                        ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 0,
                                        ),
                                    itemCount: cubit.store.branches!.length)
                                : Container(),
                          ),

                          ///end tabs
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showCustomDialog(BuildContext context, Services srv) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      srv.name,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const Divider(),
            ],
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.height * 0.6,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (srv.details != null)
                    HtmlWidget(
                      srv.details!,
                      enableCaching: true,
                    ),
                ],
              ),
            ),
          ),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
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
    );
  }
}
