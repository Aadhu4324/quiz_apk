import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_apk/api/question_model.dart';

class QuizServices {
  static const api =
      "https://opentdb.com/api.php?amount=20&category=18&difficulty=medium&type=multiple";

  Future<List<Question>?> getQuizData() async {
    final response = await http.get(Uri.parse(api));
    final data = jsonDecode(response.body);
    try {
      List list = data["results"];
      return list
          .map(
            (e) => Question.fromJson(e),
          )
          .toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
}
