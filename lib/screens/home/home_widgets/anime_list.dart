import 'package:flutter/material.dart';
import 'package:flutter_mal/constants/pallete.dart';
import 'package:flutter_mal/models/anime_model.dart' hide Image;
import 'package:flutter_mal/screens/home/home_widgets/anime_detail.dart';

class AnimeList extends StatelessWidget {
  final List<AnimeModel> data;
  const AnimeList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 270,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final AnimeModel item = data[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimeDetail(anime: item),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: 141,
                    height: 200,
                    child: Hero(
                      tag: item.malId.toString(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          color: Colors.black54,
                          child: Image.network(
                            item.image ?? "",
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: Text('Failed to load image'));
                            },
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
                      item.titleJapanese ?? "",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: Pallete().textSecondary,
                      ),
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
