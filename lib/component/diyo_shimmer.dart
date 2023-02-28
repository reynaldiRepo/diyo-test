import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DiyoShimmer extends StatelessWidget {
  final Widget child;
  const DiyoShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 223, 223, 223),
      highlightColor: const Color.fromARGB(255, 190, 186, 186),
      child: child,
    );
  }
}
