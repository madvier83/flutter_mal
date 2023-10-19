import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_event.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_state.dart';
import 'package:flutter_mal/constants/route.dart';
import 'package:flutter_mal/models/database/database_helper.dart';
import 'package:flutter_mal/models/history_model.dart';
import 'package:flutter_mal/screens/search_result/search_result_widget/anime_search_result.dart';
import 'package:flutter_mal/widgets/bottom_navigtion_bar_global.dart';
import 'package:flutter_mal/widgets/heading.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  List<HistoryModel> history = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    history = await DatabaseHelper().getHistory();
    history = history.reversed.toList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    void searchAnime() {
      context
          .read<AnimeSearchBloc>()
          .add(GetAnimeSearch(q: searchController.text));

      Navigator.of(context).pushNamedAndRemoveUntil(
          DefinedRoute().searchResult, (route) => false);
    }

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
              child: TextField(
                autofocus: true,
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
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Heading("Search History"),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: history.length,
              itemBuilder: (context, index) {
                final data = history[index];
                return GestureDetector(
                  onTap: () {
                    searchController.text = data.name;
                    searchAnime();
                  },
                  child: ListTile(
                    title: Text(data.name),
                    leading: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        await DatabaseHelper().deleteHistory(data.id ?? -1);
                        history = await DatabaseHelper().getHistory();
                        history = history.reversed.toList();
                        setState(() {});
                      },
                    ),
                    trailing: IconButton(
                      icon: const RotatedBox(
                        quarterTurns: -1,
                        child: Icon(Icons.arrow_outward_rounded),
                      ),
                      onPressed: () {
                        searchController.text = data.name;
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbarGlobal(),
    );
  }
}
