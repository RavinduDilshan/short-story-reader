import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sinhala_short_stories/drawer.dart';
import 'package:sinhala_short_stories/services/firebase_service.dart';
import './posts_model.dart';
import './post_detail.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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

    createTile(Post post) => Hero(
          tag: post.id,
          child: Material(
            elevation: 15.0,
            shadowColor: Color(0xff5b5858).withOpacity(0.5),
            child: InkWell(
              onTap: () => Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) => PostDetail(post.id),
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
            image: DecorationImage(
                image: AssetImage('res/0.png'), fit: BoxFit.cover)),
        child: Scaffold(
          drawer: MyDrawer(),
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: FutureBuilder(
            future: FirebaseService().getAllStoriesList(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Post>?> snapshot) {
              if (snapshot.hasData) {
                List<Post> posts = snapshot.data ?? [];

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
                          children:
                              posts.map((post) => createTile(post)).toList(),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Color(0xff5b5858),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'මදක් රැදීසිටින්න...',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff5b5858)),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}
