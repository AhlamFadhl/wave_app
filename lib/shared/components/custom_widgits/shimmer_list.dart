import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  final int itemCount;
  const ShimmerList({super.key, 
    this.itemCount = 4,
  });
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.white,
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: itemCount, // Adjust the count based on your needs

        separatorBuilder: (context, index) => const SizedBox(
          height: 12,
        ),
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              height: 100,
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
