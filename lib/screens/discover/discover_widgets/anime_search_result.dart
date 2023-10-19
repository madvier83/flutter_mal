import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_state.dart';
import 'package:flutter_mal/bloc/anime_this_season/anime_this_season_bloc.dart';
import 'package:flutter_mal/bloc/anime_this_season/anime_this_season_state.dart';
import 'package:flutter_mal/screens/home/home_widgets/anime_detail.dart';
import 'package:flutter_mal/screens/home/home_widgets/anime_grid.dart';
import 'package:flutter_mal/screens/home/home_widgets/anime_list_loading.dart';
import 'package:flutter_mal/widgets/badge.dart';
import 'package:flutter_mal/widgets/heading.dart';
import 'package:flutter_mal/widgets/small.dart';

class AnimeSearchResult extends StatefulWidget {
  const AnimeSearchResult({super.key});

  @override
  State<AnimeSearchResult> createState() => _AnimeSearchResultState();
}

class _AnimeSearchResultState extends State<AnimeSearchResult> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Heading("Search Result"),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          BlocBuilder<AnimeSearchBloc, AnimeSearchState>(
            builder: (context, state) {
              if (state is GetAnimeSearchSuccess) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.animeSearch.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = state.animeSearch[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnimeDetail(anime: data),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                                height: 100,
                                child: Hero(
                                  tag: data.malId.toString(),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      color: Colors.black54,
                                      child: Image.network(
                                        data.image ?? "",
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                              child:
                                                  Text('Failed to load image'));
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        data.title ?? "-",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Small(
                                        "${data.episodes.toString() ?? "-"} Eps - ${data.season ?? "?"} ${data.year ?? "?"}",
                                      ),
                                      const SizedBox(height: 8),
                                      TextBadge(
                                        text: "${data.score ?? "?"} ★",
                                        color: Colors.orange,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
