import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinhala_short_stories/post_detail.dart';
import 'package:sinhala_short_stories/providers/favorite_story_provider.dart';

class FavoriteScreen extends StatelessWidget {
  final appBar = AppBar(
    iconTheme: IconThemeData(color: Color(0xff5b5858)),
    flexibleSpace: const Image(
      image: AssetImage('res/containerBG.png'),
      fit: BoxFit.cover,
    ),
    elevation: .5,
    title: Text(
      'ප්‍රියතම කතා',
      style: TextStyle(color: Color(0xff5b5858), fontWeight: FontWeight.bold),
    ),
  );

  FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('res/0.png'), fit: BoxFit.cover)),
        child: FutureBuilder(
            future: Provider.of<FavoriteStories>(context, listen: false)
                .fetchFavorites(),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<FavoriteStories>(
                    builder: (context, story, ch) => story
                            .getFavoriteStorie.isEmpty
                        ? const Center(
                            child: Text(
                              'ප්‍රියතම කතා නොමැත',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (ctx, i) => GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                    builder: (
                                      context,
                                    ) =>
                                        PostDetail(
                                            story.getFavoriteStorie[i].id),
                                  ),
                                );
                              },
                              child: Card(
                                color: Color(0xff5b5858).withOpacity(0.01),
                                child: ListTile(
                                  leading: Image.memory(
                                    base64Decode(
                                        story.getFavoriteStorie[i].image),
                                    fit: BoxFit.cover,
                                  ),
                                  subtitle:
                                      Text(story.getFavoriteStorie[i].author),
                                  title: Text(story.getFavoriteStorie[i].title),
                                  trailing: Wrap(
                                    spacing: 12, // space between two icons
                                    children: <Widget>[
                                      GestureDetector(
                                          child: const Icon(Icons.delete),
                                          onTap: () => showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: const Text(
                                                      'ඉවත් කිරීම තහවුරු කරන්න'),
                                                  content: const Text(
                                                      'ප්‍රියතම ලැයිස්තුවෙන් ඉවත් කරන්න?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child: const Text('නෑ'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        await Provider.of<
                                                                    FavoriteStories>(
                                                                context,
                                                                listen: false)
                                                            .deleteFavorite(story
                                                                .getFavoriteStorie[
                                                                    i]
                                                                .id);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('ඔව්'),
                                                    ),
                                                  ],
                                                ),
                                              )), // icon-1
                                      GestureDetector(
                                        child: const Icon(
                                            Icons.arrow_forward_ios_sharp),
                                        onTap: () {},
                                      ), // icon-2
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            itemCount: story.getFavoriteStorie.length,
                          ),
                  )),
      ),
    );
  }
}
