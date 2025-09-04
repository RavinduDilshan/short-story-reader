import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinhala_short_stories/drawer.dart';
import 'package:sinhala_short_stories/helpers/enums.dart';
import 'package:sinhala_short_stories/providers/home_provider.dart';
import 'models/story_model.dart';
import 'story_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    //app bar
    final appBar = AppBar(
      iconTheme: IconThemeData(color: Color(0xff5b5858)),
      flexibleSpace: const Image(
        image: AssetImage('res/containerBG.png'),
        fit: BoxFit.cover,
      ),
      elevation: .5,
      title: Text(
        'කෙටි කතා',
        style: TextStyle(color: Color(0xff5b5858), fontWeight: FontWeight.bold),
      ),
    );

    createTile(Story post) => Hero(
          tag: post.id,
          child: Material(
            elevation: 15.0,
            shadowColor: Color(0xff5b5858).withOpacity(0.5),
            child: InkWell(
              onTap: () => Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) => StoryDetails(post.id),
                ),
              ),
              child: Image.memory(
                base64Decode(post.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );

    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('res/0.png'), fit: BoxFit.cover)),
        child: Scaffold(
          key: _key,
          drawer: MyDrawer(key: _key),
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: Consumer<HomeProvider>(
            builder: (context, value, child) {
              switch (value.loadingState) {
                case LoadingState.loading:
                  return const Center(child: CircularProgressIndicator(color: Colors.white));
                case LoadingState.error:
                  return const Center(child: Text('Something went wrong'));
                case LoadingState.success:
                  return Scrollbar(
                    child: CustomScrollView(
                      primary: false,
                      slivers: <Widget>[
                        SliverPadding(
                          padding: const EdgeInsets.all(16.0),
                          sliver: SliverGrid.count(
                            childAspectRatio: 2 / 3,
                            crossAxisCount: 3,
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 20.0,
                            children: value.stories.map((post) => createTile(post)).toList(),
                          ),
                        )
                      ],
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ));
  }
}
