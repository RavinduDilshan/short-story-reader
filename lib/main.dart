import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sinhala_short_stories/firebase_options.dart';
import 'package:sinhala_short_stories/providers/home_provider.dart';
import 'package:sinhala_short_stories/tab_screen.dart';
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
    return ChangeNotifierProvider(
      create: (ctx) => HomeProvider()..fetchAllStories(),
        child: MaterialApp(
          title: 'Book App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            platform: TargetPlatform.android,
          ),
          home: TabScreen(),
        ));
  }
}
