import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sinhala_short_stories/authors.dart';
import 'package:sinhala_short_stories/contact.dart';
import 'package:sinhala_short_stories/drawer.dart';
import 'package:sinhala_short_stories/home.dart';
import 'package:sinhala_short_stories/tab_screen.dart';

class AppRouter {
  AppRouter._();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      ShellRoute(
         builder: (context, state, child) {
          return Scaffold(
            drawer: MyDrawer(),
            body: child, // 👈 swapped on navigation
          );
        },
        routes: <RouteBase>[
           GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return TabScreen(key:UniqueKey());
            },
          ),
          GoRoute(
            path: '/home',
            builder: (BuildContext context, GoRouterState state) {
              return Home(key: UniqueKey());
            },
          ),
          GoRoute(
            path: '/authors',
            builder: (BuildContext context, GoRouterState state) {
              return Authors(key: UniqueKey());
            },
          ),
          GoRoute(
            path: '/contact',
            builder: (BuildContext context, GoRouterState state) {
              return Contact();
            },
          ),
        ],
      ),
    ],
  );
}
