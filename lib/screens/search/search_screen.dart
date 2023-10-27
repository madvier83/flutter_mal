import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_event.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_state.dart';
import 'package:flutter_mal/bloc/search_query/search_cubit.dart';
import 'package:flutter_mal/bloc/search_query/search_state.dart';
import 'package:flutter_mal/bloc/trace_image/trace_image_cubit.dart';
import 'package:flutter_mal/bloc/trace_image/trace_image_state.dart';
import 'package:flutter_mal/constants/formatter.dart';
import 'package:flutter_mal/constants/route.dart';
import 'package:flutter_mal/models/database/database_helper.dart';
import 'package:flutter_mal/models/history_model.dart';
import 'package:flutter_mal/models/trace_model.dart';
import 'package:flutter_mal/widgets/bottom_navigtion_bar_global.dart';
import 'package:flutter_mal/widgets/typography/heading.dart';
import 'package:flutter_mal/widgets/typography/small.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
    void searchAnime(String q) {
      context.read<AnimeSearchBloc>().add(GetAnimeSearch(q: q));

      Navigator.of(context).pushReplacementNamed(DefinedRoute().searchResult);
    }

    return Scaffold(
      floatingActionButton: BlocListener<TraceImageCubit, TraceImageState>(
        listener: (context, state) {
          if (state is TraceImageSelected) {
            showModalBottomSheet(
              showDragHandle: true,
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                File(state.file.path),
                              ),
                            ),
                            const SizedBox(height: 32),
                            const CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is TraceImageError) {
            showModalBottomSheet(
              showDragHandle: true,
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(state.message)],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is TraceImageSuccess) {
            Navigator.of(context).pop();
            showModalBottomSheet(
              showDragHandle: true,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 32),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Heading("Image Search Result"),
                          const SizedBox(height: 32),
                          BlocBuilder<AnimeSearchBloc, AnimeSearchState>(
                              builder: (context, stateSearch) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.data.result!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final Result data = state.data.result![index];
                                // print(data.anilist?.title?.romaji ?? false);
                                if (data.anilist?.isAdult == true) {
                                  return const SizedBox();
                                }
                                return BlocBuilder<SearchCubit, SearchState>(
                                    builder: (contextSearch, stateSearch) {
                                  return GestureDetector(
                                    onTap: () {
                                      stateSearch.searchController.text =
                                          data.anilist?.title?.romaji ?? "";
                                      context.read<AnimeSearchBloc>().add(
                                            GetAnimeSearch(
                                                q: data.anilist?.title
                                                        ?.romaji ??
                                                    ""),
                                          );
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              DefinedRoute().searchResult);
                                    },
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 70,
                                              height: 100,
                                              child: Hero(
                                                tag: data.filename ?? "",
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: Container(
                                                    color: Colors.black54,
                                                    child: Image.network(
                                                      data.image ?? "",
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return const Center(
                                                          child: Text(
                                                            'Failed to load image',
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data.anilist?.title
                                                              ?.romaji ??
                                                          "-",
                                                      softWrap: true,
                                                    ),
                                                    Small(
                                                      'Episode ${data.episode?.toString() ?? "1"} (${Formatter().formatTime(data.from ?? 0)} - ${Formatter().formatTime(data.to ?? 0)}) ',
                                                    ),
                                                    Small(
                                                      '${NumberFormat('#,###').format((data.similarity ?? 0) * 100)}% Similarity',
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
                                });
                              },
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
        child: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          onPressed: () async {
            final BuildContext currentContext = context;
            final image =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (image != null) {
              if (mounted) {
                currentContext.read<TraceImageCubit>().selectImage(image);
                currentContext.read<TraceImageCubit>().searchImage(image);
              }
            }
          },
          label: const Text('Search With Image'),
          icon: const Icon(Icons.image_search_rounded),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
      body: BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: TextField(
                    controller: state.searchController,
                    autofocus: true,
                    onSubmitted: (value) =>
                        searchAnime(state.searchController.text),
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
                        onPressed: () => state.searchController.clear(),
                        icon: const Icon(Icons.clear_rounded),
                      ),
                    ),
                  )),
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
                      state.searchController.text = data.name;
                      searchAnime(state.searchController.text);
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
                          state.searchController.text = data.name;
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        );
      }),
      bottomNavigationBar: const BottomNavbarGlobal(),
    );
  }
}
