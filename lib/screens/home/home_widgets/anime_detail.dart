import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/bookmark/bookmark_cubit.dart';
import 'package:flutter_mal/bloc/bookmark/bookmark_state.dart';
import 'package:flutter_mal/constants/formatter.dart';
import 'package:flutter_mal/models/anime_model.dart' hide Image;
import 'package:flutter_mal/widgets/typography/badge.dart';
import 'package:flutter_mal/widgets/typography/heading2.dart';
import 'package:flutter_mal/widgets/typography/small.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AnimeDetail extends StatefulWidget {
  final AnimeModel anime;
  const AnimeDetail({super.key, required this.anime});

  @override
  State<AnimeDetail> createState() => _AnimeDetailState();
}

class _AnimeDetailState extends State<AnimeDetail> {
  @override
  void initState() {
    super.initState();
    context.read<BookmarkCubit>().getBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: widget.anime.trailer?.youtubeId ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        loop: true,
        isLive: false,
        forceHD: false,
        captionLanguage: 'en',
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.anime.malId.toString(),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Center(child: Image.network(widget.anime.image ?? "")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  const Small('Title'),
                  Heading2('${widget.anime.title}'),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      TextBadge(
                        text: "${widget.anime.score} ★",
                        color: Colors.orange,
                      ),
                      ...List.generate(
                        widget.anime.genres?.length ?? 0,
                        (index) => TextBadge(
                          text: widget.anime.genres?[index].name ?? "",
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: controller,
                    ),
                    builder: (context, player) {
                      return Column(
                        children: [
                          YoutubePlayer(
                            controller: controller,
                            showVideoProgressIndicator: true,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Small('Synopsis'),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.anime.synopsis ?? "No synopsis",
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 8,
                  ),
                  const Small('Synonims'),
                  const SizedBox(
                    height: 8,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        Text(widget.anime.titleSynonyms?[index] ?? ""),
                    itemCount: widget.anime.titleSynonyms?.length ?? 0,
                  ),
                  Text(widget.anime.titleEnglish ?? "-"),
                  const SizedBox(height: 16),
                  const Small("Season"),
                  Text(
                      '${widget.anime.season ?? "?"} - ${widget.anime.year ?? "?"}'),
                  const SizedBox(height: 16),
                  const Small("Aired"),
                  Text(
                    widget.anime.aired!.from == true
                        ? ""
                        : Formatter()
                            .date(widget.anime.aired!.from ?? DateTime.now()),
                  ),
                  const SizedBox(height: 16),
                  const Small("Source"),
                  Text(widget.anime.source ?? "-"),
                  const SizedBox(height: 16),
                  const Small("Studio"),
                  Text(widget.anime.studios!.map((e) => e.name).toString()),
                  const SizedBox(height: 16),
                  const Small("Rating"),
                  Text(widget.anime.rating ?? "-"),
                  const SizedBox(height: 16),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<BookmarkCubit, BookmarkState>(
            builder: (context, state) {
              if (state is BookmarkSuccess) {
                final data = widget.anime;
                bool isMarked = false;
                for (var item in state.bookmarkList) {
                  if (item.malId == data.malId) {
                    isMarked = true;
                    break;
                  }
                }
                if (isMarked == true) {
                  return FloatingActionButton.extended(
                    heroTag: "fab2",
                    onPressed: () {
                      context.read<BookmarkCubit>().deleteBookmark(data);
                    },
                    label: const Text("Remove From Bookmark"),
                    icon: const Icon(Icons.bookmark),
                  );
                } else {
                  return FloatingActionButton.extended(
                    heroTag: "fab2",
                    onPressed: () {
                      context.read<BookmarkCubit>().saveBookmark(data);
                    },
                    label: const Text("Save To Bookmark"),
                    icon: const Icon(Icons.bookmark_border),
                  );
                }
              } else if (state is BookmarkLoading) {
                return FloatingActionButton.extended(
                  heroTag: "fab2",
                  onPressed: () async {},
                  label: const Text("Loading..."),
                );
              }

              return const SizedBox();
            },
          ),
          const SizedBox(
            width: 8,
          ),
          FloatingActionButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
