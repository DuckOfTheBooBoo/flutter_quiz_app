import 'dart:convert';

import 'package:flutter/services.dart';

Question questionsFromJson(String str) => Question.fromMap(json.decode(str));

Map<String, String> jsonAssetMap = {
  "devops": "assets/questions/devops.json",
  "docker": "assets/questions/docker.json",
  "html": "assets/questions/html.json",
  "javascript": "assets/questions/javascript.json",
  "kubernetes": "assets/questions/kubernetes.json",
  "laravel": "assets/questions/laravel.json",
  "linux": "assets/questions/linux.json",
  "php": "assets/questions/php.json",
  "sql": "assets/questions/sql.json",
  "wordpress": "assets/questions/wordpress.json",
};

class InvalidQuestionKey implements Exception {
  String cause;
  InvalidQuestionKey(this.cause);
}

Future<List<dynamic>> parseFromJsonAsset(String assetPath) async {
  var jsonStr = await rootBundle.loadString(assetPath);
  return jsonDecode(jsonStr);
}

Future<List<Question>> getQuestions(String quizName) async {
  if (!jsonAssetMap.containsKey(quizName)) {
    throw InvalidQuestionKey("$quizName is not a valid key.");
  }

  String assetPath = jsonAssetMap[quizName]!;
  var questionsMap = await parseFromJsonAsset(assetPath);
  return questionsMap.map((question) => Question.fromMap(question)).toList();
}

class Question {
  String id;
  String question;
  Map<String, dynamic> answers;
  List<Tag> tags;
  String category;
  String difficulty;
  String correctAnswer;

  Question({
    required this.id,
    required this.question,
    required this.answers,
    required this.tags,
    required this.category,
    required this.difficulty,
    required this.correctAnswer,
  });

  factory Question.fromMap(Map<String, dynamic> json) => Question(
        id: json["id"].toString(),
        question: json["question"],
        answers: json["answers"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromMap(x))),
        category: json["category"],
        difficulty: json["difficulty"],
        correctAnswer: json["correct_answer"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "question": question,
        "answers": answers,
        "tags": List<dynamic>.from(tags.map((x) => x.toMap())),
        "category": category,
        "difficulty": difficulty,
        "correct_answer": correctAnswer,
      };
}

class Tag {
  String name;

  Tag({
    required this.name,
  });

  factory Tag.fromMap(Map<String, dynamic> json) => Tag(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
