import 'package:flutter/material.dart';
import 'package:sinhala_short_stories/helpers/enums.dart';
import 'package:sinhala_short_stories/models/story_model.dart';
import 'package:sinhala_short_stories/services/firebase_service.dart';

class StoryDetailsProvider extends ChangeNotifier {
  LoadingState loadingState = LoadingState.idle;
  Story? story;

  Future fetchStoryById(String id) async {
    loadingState = LoadingState.loading;
    notifyListeners();
    story = await FirebaseService().getStoryById(id);
    loadingState = LoadingState.success;
    notifyListeners();
  }
}
