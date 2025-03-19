// # Data layer (models, datasources)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n/core/errors.dart';

class Post {
  final String id;
  final String content;
  final DateTime timestamp;

  Post({
    required this.id,
    required this.content,
    required this.timestamp,
  });
}

class PostRemoteDataSource {
  final FirebaseFirestore _firestore;

  PostRemoteDataSource(this._firestore);

  Future<List<Post>> getPosts() async {
    try {
      final snapshot = await _firestore.collection('posts').get();
      return snapshot.docs.map((doc) {
        return Post(
          id: doc.id,
          content: doc['content'],
          timestamp: (doc['timestamp'] as Timestamp).toDate(),
        );
      }).toList();
    } on FirebaseException {
      throw NetworkError();
    }
  }

  Future<void> createPost(String content) async {
    try {
      await _firestore.collection('posts').add({
        'content': content,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } on FirebaseException {
      throw NetworkError();
    }
  }
}