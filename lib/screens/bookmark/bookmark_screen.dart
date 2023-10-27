import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/bookmark/bookmark_cubit.dart';
import 'package:flutter_mal/bloc/bookmark/bookmark_state.dart';
import 'package:flutter_mal/screens/home/home_widgets/anime_detail.dart';
import 'package:flutter_mal/widgets/appbar_global.dart';
import 'package:flutter_mal/widgets/bottom_navigtion_bar_global.dart';
import 'package:flutter_mal/widgets/drawer_global.dart';
import 'package:flutter_mal/widgets/typography/badge.dart';
import 'package:flutter_mal/widgets/typography/heading.dart';
import 'package:flutter_mal/widgets/typography/small.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookmarkCubit>().getBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const DrawerGlobal(),
      appBar: AppBarGlobal(),
      body: SingleChildScrollView(
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
                  Heading("Bookmarks"),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<BookmarkCubit, BookmarkState>(
              builder: (context, state) {
                if (state is BookmarkLoading) {
                  return const SizedBox(
                      height: 720,
                      child: Center(child: CircularProgressIndicator()));
                } else if (state is BookmarkSuccess) {
                  if (state.bookmarkList.isEmpty) {
                    return const SizedBox(
                      height: 720,
                      child: Center(
                        child: Small("No Bookmark"),
                      ),
                    );
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.bookmarkList.length,
                    itemBuilder: (context, index) {
                      final data = state.bookmarkList[index];
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
                                                  Text('Failed to load image'),
                                            );
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
                                          "${data.episodes.toString()} Eps - ${data.season ?? "?"} ${data.year ?? "?"}",
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
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbarGlobal(),
    );
  }
}
