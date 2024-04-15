import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:string_2_icon/string_2_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wave_app/model/category.dart';
import 'package:wave_app/model/section.dart';
import 'package:wave_app/model/store.dart';
import 'package:wave_app/shared/components/custom_widgits/custom_image.dart';
import 'package:wave_app/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:wave_app/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:wave_app/shared/components/custom_widgits/custom_text.dart';
import 'package:wave_app/shared/styles/colors.dart';

Widget setShimmer(bool isShimmer,
    {required Widget child,
    Color baseColor = const Color(0xffe3e3e3),
    Color highlightColor = Colors.white}) {
  if (isShimmer) {
    return Shimmer.fromColors(
        baseColor: baseColor, highlightColor: highlightColor, child: child);
  } else {
    return child;
  }
}

Widget buildSectionCard(Section section, Function() onTap) => InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade100),
        child: section.isLoading!
            ? const CustomProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CustomImage(
                      url: section.image,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const CustomSizedBox(height: 10),
                  Expanded(
                    child: CustomText(
                      section.name,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
      ),
    );

Widget buildSliders(List<String>? slider,
        {bool autoPlay = true,
        double viewportFraction = 0.9,
        double height = 200}) =>
    SizedBox(
      height: height,
      child: slider != null
          ? CarouselSlider.builder(
              options: CarouselOptions(
                height: height,
                aspectRatio: 16 / 9,
                viewportFraction: viewportFraction,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: autoPlay,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {},
                scrollDirection: Axis.horizontal,
              ),
              itemCount: slider.length,
              itemBuilder: (context, index, realIndex) => Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade200)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: CustomImage(
                  url: slider[index],
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              color: baseColor,
            ),
    );

Widget buildCategoryCard(Categories cat) => Container(
      width: 140,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CustomImage(url: cat.image),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CustomText(
                    cat.name,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (cat.current!)
            const SizedBox(
              width: 50,
              child: Divider(
                height: 0,
                thickness: 2,
                color: primaryColor,
              ),
            ),
        ],
      ),
    );

Widget buildStoreCard(Store store) => Container(
      width: 150,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      alignment: AlignmentDirectional.topStart,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 1,
              color: Colors.grey.shade200)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.grey,
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: Stack(
              children: [
                CustomImage(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  url: store.image,
                ),
                PositionedDirectional(
                    top: 0,
                    end: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon((store.hasFavorite ?? false)
                          ? Icons.favorite
                          : Icons.favorite_border),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          buidRateStart(store.review!.rating),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomText(
                    store.name,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 10, vertical: 5),
                  color: primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.home_filled,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CustomText(
                            store.branchesCount.toString(),
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.people_alt,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CustomText(
                            store.staffCount.toString(),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget buidRateStart(int? rating) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          size: 15,
          color: ((rating ?? 0) >= 1) ? primaryColor : Colors.grey,
        ),
        Icon(
          Icons.star,
          size: 15,
          color: ((rating ?? 0) >= 2) ? primaryColor : Colors.grey,
        ),
        Icon(
          Icons.star,
          size: 15,
          color: ((rating ?? 0) >= 3) ? primaryColor : Colors.grey,
        ),
        Icon(
          Icons.star,
          size: 15,
          color: ((rating ?? 0) >= 4) ? primaryColor : Colors.grey,
        ),
        Icon(
          Icons.star,
          size: 15,
          color: ((rating ?? 0) >= 5) ? primaryColor : Colors.grey,
        ),
        CustomText(
          rating != null ? "($rating)" : "",
          fontSize: 12,
          color: Colors.grey.shade800,
        ),
      ],
    );

Widget buildDepartment(Departments department) => Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: department.isSelected!
                    ? primaryColor
                    : Colors.grey.shade200,
                blurRadius: 0,
                spreadRadius: 1,
                offset: const Offset(0, 0))
          ]),
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImage(
            url: department.image,
            fit: BoxFit.cover,
            height: 120,
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 5),
              child: CustomText(
                department.name,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );

Widget buidServiceCard(Services srv, {required Function() onTapInfo}) =>
    Container(
      height: 180,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          children: [
            CustomImage(
              url: srv.image,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            PositionedDirectional(
              end: -2,
              child: InkWell(
                onTap: onTapInfo,
                child: Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: secondColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                srv.duration,
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              CustomText(
                srv.price,
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomText(
              srv.name,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ]),
    );

Widget buildSocialIcon(Socials icn, size) => InkWell(
      onTap: () async {
        Uri? luri;
        if (icn.name == "email") {
          luri = Uri(
            scheme: 'mailto',
            path: "kirtan@gmail.com",
            queryParameters: {'subject': "Testing subject"},
          );
        } else if (icn.name == "phone") {
          luri = Uri(
            scheme: 'tel',
            path: icn.link,
          );
          launchUrl(luri);
          return;
        } else if (icn.name == "sms") {
          luri = Uri(
            scheme: 'sms',
            path: icn.link!,
          );
          launchUrl(luri);
          return;
        } /* else if (icn.name == "whatsapp") {
          luri = Uri(
            scheme: 'https',
            path: icn.link!,
          );
  
        } else if (icn.name == "instagram") {
          luri = Uri(scheme: 'https', path: icn.link!);
        } else if (icn.name == "facebook") {
          luri = Uri(scheme: 'https', path: icn.link!);
        } else {
          luri = Uri(scheme: 'https', path: icn.link!);
        }*/
        launch(icn.link!);
      },
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: secondColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icn.icon == null
              ? Icons.phone
              : String2Icon.getIconDataFromString(icn.icon!),
          color: Colors.white,
          size: 35,
        ),
      ),
    );
