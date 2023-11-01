import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_bloc.dart';
import 'package:flutter_mal/bloc/anime_this_season/anime_this_season_bloc.dart';
import 'package:flutter_mal/bloc/anime_top/anime_top_bloc.dart';
import 'package:flutter_mal/bloc/anime_upcoming/anime_upcoming_bloc.dart';
import 'package:flutter_mal/bloc/bookmark/bookmark_cubit.dart';
import 'package:flutter_mal/bloc/google_auth/google_auth_cubit.dart';
import 'package:flutter_mal/bloc/routes/route_cubit.dart';
import 'package:flutter_mal/bloc/search_query/search_cubit.dart';
import 'package:flutter_mal/bloc/trace_image/trace_image_cubit.dart';
import 'package:flutter_mal/firebase_options.dart';
import 'package:flutter_mal/screens/bookmark/bookmark_screen.dart';
import 'package:flutter_mal/screens/login/login_screen.dart';
import 'package:flutter_mal/screens/register/register_screen.dart';
import 'package:flutter_mal/screens/search_result/search_result_screen.dart';
import 'package:flutter_mal/screens/home/home_screen.dart';
import 'package:flutter_mal/screens/search/search_screen.dart';
import 'package:flutter_mal/screens/splash/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/route.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RouteCubit()),
        BlocProvider(create: (context) => GoogleAuthCubit()),
        BlocProvider(create: (context) => AnimeThisSeasonBloc()),
        BlocProvider(create: (context) => AnimeUpcomingBloc()),
        BlocProvider(create: (context) => AnimeTopBloc()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => AnimeSearchBloc()),
        BlocProvider(create: (context) => TraceImageCubit()),
        BlocProvider(create: (context) => BookmarkCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      initialRoute: DefinedRoute().splash,
      routes: {
        DefinedRoute().splash: (context) => const SplashScreen(),
        DefinedRoute().login: (context) => const LoginScreen(),
        DefinedRoute().register: (context) => const RegisterScreen(),
        DefinedRoute().home: (context) => const HomeScreen(),
        DefinedRoute().search: (context) => const SearchScreen(),
        DefinedRoute().searchResult: (context) => const SearchResultScreen(),
        DefinedRoute().bookmark: (context) => const BookmarkScreen(),
      },
    );
  }
}
