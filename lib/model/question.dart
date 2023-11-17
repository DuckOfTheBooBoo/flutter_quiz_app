import 'dart:convert';

import 'package:flutter/services.dart';

Question questionsFromJson(String str) => Question.fromJson(json.decode(str));

Map<String, String> jsonAssetMap = {
  "devops": "assets/questions/devops.json",
  "docker": "assets/questions/docker.json",
  "kubernetes": "assets/questions/kubernetes.json",
  "linux": "assets/questions/linux.json",
  "programming": "assets/questions/programming.json",
  "sql": "assets/questions/sql.json"
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
  return questionsMap.map((question) => Question.fromJson(question)).toList();
}

class Question {
  int id;
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

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        answers: json["answers"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        category: json["category"],
        difficulty: json["difficulty"],
        correctAnswer: json["correct_answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answers": answers,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
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

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
