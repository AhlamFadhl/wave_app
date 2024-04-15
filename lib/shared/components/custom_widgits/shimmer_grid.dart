import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGrid extends StatelessWidget {
  int itemCount;
  int crossAxisCount;
  double mainAxisSpacing;
  double crossAxisSpacing;
  ShimmerGrid({
    this.itemCount = 4,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 20.0,
    this.crossAxisSpacing = 20.0,
  });
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.white,
      child: GridView.builder(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: itemCount, // Adjust the count based on your needs

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, // number of items in each row
          mainAxisSpacing: mainAxisSpacing, // spacing between rows
          crossAxisSpacing: crossAxisSpacing, // spacing between columns
        ),
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade100),
            ),
          );
        },
      ),
    );
  }
}
