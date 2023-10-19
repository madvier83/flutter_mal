import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_event.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_state.dart';
import 'package:flutter_mal/screens/discover/discover_widgets/anime_search_result.dart';
import 'package:flutter_mal/widgets/bottom_navigtion_bar_global.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void searchAnime() {
      context.read<AnimeSearchBloc>().add(
            GetAnimeSearch(q: searchController.text),
          );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(),
            Text("MAL Viewer"),
            CircleAvatar(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: TextField(
                controller: searchController,
                onSubmitted: (value) => searchAnime(),
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      searchAnime();
                    },
                  ),
                ),
              ),
            ),
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
