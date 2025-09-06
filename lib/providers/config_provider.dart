import 'package:flutter/material.dart';
import 'package:sinhala_short_stories/services/firebase_service.dart';

class ConfigProvider extends ChangeNotifier {
  String? playstoreUrl;

  getPlaystoreUrl() async {
    try {
      playstoreUrl = await FirebaseService().getPlaystoreUrl();
    } catch (err) {
      throw ('failed to get config value');
    }
  }
}
