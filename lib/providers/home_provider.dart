import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sinhala_short_stories/helpers/enums.dart';
import 'package:sinhala_short_stories/models/story_model.dart';
import 'package:sinhala_short_stories/services/firebase_service.dart';

class HomeProvider extends ChangeNotifier {
  List<Story> stories = [];
  LoadingState loadingState = LoadingState.idle;
  StreamSubscription? _storiesSubscription;

  fetchAllStories() {
    loadingState = LoadingState.loading;
    notifyListeners();
    _storiesSubscription = FirebaseService().getAllStoriesList().listen((result) {
      stories = result ?? [];
      loadingState = LoadingState.success;
      notifyListeners();
    }, onError: (error) {
      loadingState = LoadingState.error;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _storiesSubscription?.cancel();
    super.dispose();
  }
}
