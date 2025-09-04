import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sinhala_short_stories/app_router.dart';
import 'package:sinhala_short_stories/firebase_options.dart';
import 'package:sinhala_short_stories/providers/config_provider.dart';
import 'package:sinhala_short_stories/providers/favorite_story_provider.dart';
import 'package:sinhala_short_stories/providers/home_provider.dart';
import 'package:sinhala_short_stories/providers/story_details_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await dotenv.load(fileName: '.env');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => ConfigProvider()..getPlaystoreUrl()),
          ChangeNotifierProvider(create: (ctx) => HomeProvider()..fetchAllStories()),
          ChangeNotifierProvider(create: (ctx) => FavoriteStories()),
          ChangeNotifierProvider(create: (ctx) => StoryDetailsProvider()),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          title: 'Book App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            platform: TargetPlatform.android,
          ),
        ));
  }
}
