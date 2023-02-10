import 'package:cloud_firestore/cloud_firestore.dart';

class LatestQuestion {
  String content;

  LatestQuestion({
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'latest_question': content,
    };
  }

  factory LatestQuestion.fromDocument(DocumentSnapshot doc) {
    String content = doc.get('latest_question');
    return LatestQuestion(
      content: content,
    );
  }
}
