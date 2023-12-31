import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnimeListLoading extends StatelessWidget {
  final List<String> data = [
    "Lorem ipsum dolor sit amet",
    "Lorem ipsum dolor sit amet",
    "Lorem ipsum dolor sit amet",
  ];
  AnimeListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Skeletonizer(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: 141,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Card(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 120,
                    child: Text(
                      data[index],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
