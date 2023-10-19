import 'package:flutter/material.dart';
import 'package:flutter_mal/models/anime_model.dart';
import 'package:flutter_mal/screens/home/home_widgets/anime_detail.dart';

class AnimeGrid extends StatelessWidget {
  final List<AnimeModel> data;
  const AnimeGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: Row(
                children: [
                  SizedBox(
                    width: 141,
                    height: 200,
                    child: Hero(
                      tag: item.malId.toString(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(
                                item.image ?? "",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 220,
                    child: Text(
                      item.titleJapanese ?? "",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 16,
      ),
    );
  }
}
