import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sinhala_short_stories/models/story_model.dart';

class FirebaseService {
  //get firebase collection instant
  CollectionReference stories = FirebaseFirestore.instance.collection('stories');
  //get all story list
  Stream<List<Story>?> getAllStoriesList() {
    return stories.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Story(
            id: doc.id,
            author: doc['author'],
            image: doc['image'],
            story: doc['story'],
            title: doc['title']);
      }).toList();
    });
  }

  //get a single story by id
  Future<Story?> getStoryById(String storyId) async {
    DocumentSnapshot story = await stories.doc(storyId).get();
    Story post = Story(
        id: storyId,
        author: story['author'],
        image: story['image'],
        story: story['story'],
        title: story['title']);
    return post;
  }
}
