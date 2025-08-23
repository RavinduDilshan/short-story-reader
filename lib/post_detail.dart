import 'dart:async';
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:sinhala_short_stories/providers/favorite_story_provider.dart';
import 'package:sinhala_short_stories/services/firebase_service.dart';

import 'models/story_model.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  final String storyId;

  PostDetail(this.storyId, {super.key});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Story? post;
  var isFavorite;
  @override
  void initState() {
    _getStory(widget.storyId);

    super.initState();
  }

  Future<void> _getStory(String id) async {
    var res = await FirebaseService().getStoryById(id);
    if (res == null) {
      return;
    }
    setState(() {
      post = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    isFavorite = Provider.of<FavoriteStories>(context)
        .checkFavorite((post?.id ?? -1).toString());

    const snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
        'ප්‍රියතම ලැයිස්තුවට එක් කරන ලදී',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Color(0xff5b5858),
    );

    ///scrolling text description
    final bottomContent = Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('res/containerBG.png'), fit: BoxFit.cover)),
      child: post == null
          ? SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xff5b5858),
                ),
              ),
            )
          : Text(
              post?.story ?? '',
              style: const TextStyle(
                  fontSize: 17.0,
                  height: 1.5,
                  color: Color(0xff5b5858),
                  fontWeight: FontWeight.bold),
            ),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          //toggle favorite state
          if (!isFavorite) {
            await Provider.of<FavoriteStories>(context, listen: false)
                .addFavorite(post?.title ?? '', (post?.id ?? -1).toString(),
                    post?.author ?? '', post?.image ?? '');
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else {
            //remove from favorites
            await Provider.of<FavoriteStories>(context, listen: false)
                .deleteFavorite(
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
      ),
      body: SafeArea(
        child: CustomScrollView(
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    post?.title ?? '',
                    style: TextStyle(
                        color: Color(0xff5b5858), fontWeight: FontWeight.bold),
                  ),
                ),
                background: post == null
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
                                  image: MemoryImage(
                                      base64Decode(post?.image ?? '')))),
                        ),
                      ),
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => bottomContent,
                childCount: 1,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('res/containerBG.png'),
                          fit: BoxFit.cover))),
            )
          ],
        ),
      ),
    );
  }
}
