import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_event.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_state.dart';
import 'package:flutter_mal/bloc/search_query/search_cubit.dart';
import 'package:flutter_mal/bloc/search_query/search_state.dart';
import 'package:flutter_mal/constants/route.dart';
import 'package:flutter_mal/screens/search_result/search_result_widget/anime_search_result.dart';
import 'package:flutter_mal/widgets/bottom_navigtion_bar_global.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
            ),
            Text("MAL Viewer"),
            CircleAvatar(
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(DefinedRoute().search);
                  },
                  child: BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                    return TextField(
                      controller: state.searchController,
                      enabled: false,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(DefinedRoute().searchResult);
                          },
                        ),
                      ),
                    );
                  }),
                )),
            const SizedBox(
              height: 24,
            ),
            BlocBuilder<AnimeSearchBloc, AnimeSearchState>(
              builder: (context, state) {
                if (state is GetAnimeSearchLoading) {
                  return const SizedBox(
                    height: 700,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is GetAnimeSearchSuccess) {
                  return const AnimeSearchResult();
                } else if (state is GetAnimeSearchError) {
                  return Text(state.message);
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbarGlobal(),
    );
  }
}
