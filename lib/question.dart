import 'dart:convert';

import 'package:appwrite/models.dart';
import 'package:equatable/equatable.dart';

class Question extends Equatable {
  //
  final String id;
  final String question;
  final List<String> options;
  final String answer;
  //
  const Question({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
  });

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
  factory Question.fromModel(Document document) {
    return Question(
      id: document.$id,
      question: document.data['question'],
      options: List<String>.from(document.data['options']),
      answer: document.data['answer']
    );
  }

  factory Question.fromMap(Map<String?, dynamic> map) {
    return Question(
      id: map['\$id'],
      question: map['question'],
      options: List<String>.from(map['options']),
      answer: map['answer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(id: $id, question: $question, options: $options, answer: $answer)';
  }

  /// Equality Operator
  @override
  List<Object> get props => [id, question, options, answer];
}
