import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_bloc.dart';
import 'package:flutter_mal/bloc/anime_this_season/anime_this_season_bloc.dart';
import 'package:flutter_mal/bloc/anime_top/anime_top_bloc.dart';
import 'package:flutter_mal/bloc/anime_upcoming/anime_upcoming_bloc.dart';
import 'package:flutter_mal/bloc/routes/route_cubit.dart';
import 'package:flutter_mal/screens/search_result/search_result_view.dart';
import 'package:flutter_mal/screens/home/home_view.dart';
import 'package:flutter_mal/screens/search/search_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/route.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AnimeThisSeasonBloc()),
      BlocProvider(create: (context) => AnimeUpcomingBloc()),
      BlocProvider(create: (context) => AnimeTopBloc()),
      BlocProvider(create: (context) => AnimeSearchBloc()),
      BlocProvider(create: (context) => RouteCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      initialRoute: DefinedRoute().home,
      routes: {
        DefinedRoute().home: (context) => const HomeScreen(),
        DefinedRoute().search: (context) => const SearchScreen(),
        DefinedRoute().searchResult: (context) => const SearchResultScreen(),
      },
    );
  }
}
