import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/anime_this_season/anime_this_season_bloc.dart';
import 'package:flutter_mal/bloc/anime_this_season/anime_this_season_event.dart';
import 'package:flutter_mal/bloc/anime_this_season/anime_this_season_state.dart';
import 'package:flutter_mal/bloc/anime_top/anime_top_bloc.dart';
import 'package:flutter_mal/bloc/anime_top/anime_top_event.dart';
import 'package:flutter_mal/bloc/anime_top/anime_top_state.dart';
import 'package:flutter_mal/bloc/anime_upcoming/anime_upcoming_bloc.dart';
import 'package:flutter_mal/bloc/anime_upcoming/anime_upcoming_event.dart';
import 'package:flutter_mal/bloc/anime_upcoming/anime_upcoming_state.dart';
import 'package:flutter_mal/bloc/search_query/search_cubit.dart';
import 'package:flutter_mal/bloc/search_query/search_state.dart';
import 'package:flutter_mal/constants/pallete.dart';
import 'package:flutter_mal/constants/route.dart';
import 'package:flutter_mal/screens/home/home_widgets/anime_list.dart';
import 'package:flutter_mal/screens/home/home_widgets/anime_list_loading.dart';
import 'package:flutter_mal/widgets/appbar_global.dart';
import 'package:flutter_mal/widgets/bottom_navigtion_bar_global.dart';
import 'package:flutter_mal/widgets/drawer_global.dart';
import 'package:flutter_mal/widgets/typography/heading.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AnimeThisSeasonBloc>().add(GetAnimeThisSeason());
    context.read<AnimeUpcomingBloc>().add(GetAnimeUpcoming());
    context.read<AnimeTopBloc>().add(GetAnimeTop());
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      endDrawer: const DrawerGlobal(),
      appBar: AppBarGlobal(),
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        color: Pallete().basePrimary,
        backgroundColor: Pallete().textSecondary,
        springAnimationDurationInMilliseconds: 300,
        onRefresh: () async {
          context.read<AnimeThisSeasonBloc>().add(GetAnimeThisSeason());
          context.read<AnimeUpcomingBloc>().add(GetAnimeUpcoming());
          context.read<AnimeTopBloc>().add(GetAnimeTop());
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      state.searchController.clear();
                      Navigator.of(context).pushNamed(DefinedRoute().search);
                    },
                    child: TextField(
                      enabled: false, // Disable the TextField
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
                            state.searchController.clear();
                          },
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 24,
              ),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Heading("Top Anime"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<AnimeTopBloc, AnimeTopState>(
                builder: (context, state) {
                  if (state is GetAnimeTopLoading) {
                    return AnimeListLoading();
                  }
                  if (state is GetAnimeTopSuccess) {
                    return AnimeList(data: state.animeTop);
                  }
                  return const SizedBox();
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Heading("This Season"),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<AnimeThisSeasonBloc, AnimeThisSeasonState>(
                builder: (context, state) {
                  if (state is GetAnimeThisSeasonLoading) {
                    return AnimeListLoading();
                  }
                  if (state is GetAnimeThisSeasonSuccess) {
                    return AnimeList(data: state.animeThisSeason);
                  }
                  return const SizedBox();
                },
              ),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Heading("Upcoming"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<AnimeUpcomingBloc, AnimeUpcomingState>(
                builder: (context, state) {
                  if (state is GetAnimeUpcomingLoading) {
                    return AnimeListLoading();
                  }
                  if (state is GetAnimeUpcomingSuccess) {
                    return AnimeList(data: state.animeUpcoming);
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbarGlobal(),
    );
  }
}
