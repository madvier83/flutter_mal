import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/routes/route_cubit.dart';
import 'package:flutter_mal/bloc/routes/route_state.dart';
import 'package:flutter_mal/constants/route.dart';

class BottomNavbarGlobal extends StatelessWidget {
  const BottomNavbarGlobal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouteCubit, RouteState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.index,
          onTap: (value) {
            if (value == 0) {
              Navigator.of(context).pushNamed(
                DefinedRoute().home,
              );
              context.read<RouteCubit>().navigate(index: value);
            }
            if (value == 1) {
              Navigator.of(context).pushNamed(
                DefinedRoute().search,
              );
              context.read<RouteCubit>().navigate(index: value);
            }
            if (value == 2) {
              Navigator.of(context).pushNamed(
                DefinedRoute().bookmark,
              );
              context.read<RouteCubit>().navigate(index: value);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: "My List"),
          ],
        );
      },
    );
  }
}
