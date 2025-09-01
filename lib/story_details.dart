import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:sinhala_short_stories/helpers/enums.dart';
import 'package:sinhala_short_stories/providers/story_details_provider.dart';
import 'package:flutter/material.dart';

class StoryDetails extends StatefulWidget {
  final String storyId;

  StoryDetails(this.storyId, {super.key});

  @override
  _StoryDetailsState createState() => _StoryDetailsState();
}

class _StoryDetailsState extends State<StoryDetails> {
  var isFavorite;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<StoryDetailsProvider>().fetchStoryById(widget.storyId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // isFavorite = Provider.of<FavoriteStories>(context).checkFavorite((post?.id ?? -1).toString());

    const snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
        'ප්‍රියතම ලැයිස්තුවට එක් කරන ලදී',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Color(0xff5b5858),
    );

    ///scrolling text description
    bottomContent(StoryDetailsProvider provider) => Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('res/containerBG.png'), fit: BoxFit.cover)),
          child: provider.loadingState == LoadingState.loading
              ? SizedBox(
                  height:
                      MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.4,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff5b5858),
                    ),
                  ),
                )
              : Text(
                  provider.story?.story ?? '',
                  style: const TextStyle(
                      fontSize: 17.0,
                      height: 1.5,
                      color: Color(0xff5b5858),
                      fontWeight: FontWeight.bold),
                ),
        );

    return Scaffold(
      /*  floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          //toggle favorite state
          if (!isFavorite) {
            await Provider.of<FavoriteStories>(context, listen: false).addFavorite(
                post?.title ?? '',
                (post?.id ?? -1).toString(),
                post?.author ?? '',
                post?.image ?? '');
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else {
            //remove from favorites
            await Provider.of<FavoriteStories>(context, listen: false).deleteFavorite(
              (post?.id ?? -1).toString(),
            );
          }
        },
        child: isFavorite
            ? Icon(
                Icons.favorite,
                color: Color(0xff5b5858),
                size: 50,
              )
            : Icon(
                Icons.favorite_border_outlined,
                color: Color(0xff5b5858),
                size: 50,
              ),
      ), */
      body: SafeArea(
        child: Consumer<StoryDetailsProvider>(
          builder: (context, provider, child) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xff5b5858),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  pinned: true,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: provider.loadingState == LoadingState.loading
                          ? SizedBox.shrink()
                          : Text(
                              provider.story?.title ?? '',
                              style:
                                  TextStyle(color: Color(0xff5b5858), fontWeight: FontWeight.bold),
                            ),
                    ),
                    background: provider.loadingState == LoadingState.loading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(0xff5b5858),
                            ),
                          )
                        : AspectRatio(
                            aspectRatio: 1 / 3,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      alignment: FractionalOffset.topCenter,
                                      image:
                                          MemoryImage(base64Decode(provider.story?.image ?? '')))),
                            ),
                          ),
                  ),
                  expandedHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => bottomContent(provider),
                    childCount: 1,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('res/containerBG.png'), fit: BoxFit.cover))),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
