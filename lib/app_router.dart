import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sinhala_short_stories/authors.dart';
import 'package:sinhala_short_stories/contact.dart';
import 'package:sinhala_short_stories/home.dart';
import 'package:sinhala_short_stories/story_details.dart';
import 'package:sinhala_short_stories/tab_screen.dart';

class AppRouter {
  AppRouter._();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return TabScreen();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return Home();
        },
      ),
      GoRoute(
        path: '/authors',
        builder: (BuildContext context, GoRouterState state) {
          return Authors();
        },
      ),
      GoRoute(
        path: '/contact',
        builder: (BuildContext context, GoRouterState state) {
          return Contact();
        },
      ),
      GoRoute(
        path: '/story/:id',
        builder: (BuildContext context, GoRouterState state) {
          final id = state.pathParameters['id'];
          return StoryDetails(id as String);
        },
      )
    ],
  );
}
