class Question {
  String? type;
  String? difficulty;
  String? category;
  String? question;
  String? correct_answer;
  List? incorrect_answers;
  Question(
      {this.type,
      this.difficulty,
      this.category,
      this.question,
      this.correct_answer,
      this.incorrect_answers});
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        type: json["type"],
        difficulty: json["difficulty"],
        category: json["category"],
        question: json["question"],
        correct_answer: json["correct_answer"],
        incorrect_answers: json["incorrect_answers"]);
  }
}
