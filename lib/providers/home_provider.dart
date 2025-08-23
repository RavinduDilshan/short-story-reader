import 'package:flutter/foundation.dart';
import 'package:sinhala_short_stories/helpers/enums.dart';
import 'package:sinhala_short_stories/models/story_model.dart';

class HomeProvider extends ChangeNotifier{
  final List<Story> _stories = [];
  final LoadingState _loadingState = LoadingState.idle;
}