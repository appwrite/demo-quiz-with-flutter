import 'dart:convert';

import 'package:flutter/foundation.dart';

class Question {
  String id;
  String question;
  List<String> options;
  String answer;
  Question({
    this.id,
    this.question,
    this.options,
    this.answer,
  });

  Question copyWith({
    String id,
    String question,
    List<String> options,
    String answer,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'answer': answer,
    };
  }

  /* Give a man a program, frustrate him for a day.
Teach a man to program, frustrate him for a lifetime */
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['\$id'],
      question: map['question'],
      options: List<String>.from(map['options']),
      answer: map['answer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) => Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(id: $id, question: $question, options: $options, answer: $answer)';
  }
  /*  Code is like humor. When you have to explain it, it’s bad. */
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Question &&
      other.id == id &&
      other.question == question &&
      listEquals(other.options, options) &&
      other.answer == answer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      question.hashCode ^
      options.hashCode ^
      answer.hashCode;
  }
}
