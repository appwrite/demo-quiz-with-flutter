import 'dart:convert';
import 'dart:io';

import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client();

void main() async {
  client
      .setEndpoint("https://demo.appwrite.io/v1")
      .setProject("606d5bc9de604")
      .setKey("f2a3580ec....3ed219ad");
  File json = File('./quiz_app_questions.json');
  final questions = jsonDecode(json.readAsStringSync());

  Database db = Database(client);

  final res = await db.createCollection(name: "Questions", read: [
    "*"
  ], write: [
    "role:member"
  ], rules: [
    {
      "type": "text",
      "key": "question",
      "label": "Question",
      "default": "",
      "array": false,
      "required": true,
    },
    {
      "type": "text",
      "key": "options",
      "label": "Options",
      "default": "",
      "array": true,
      "required": true,
    },
    {
      "type": "text",
      "key": "answer",
      "label": "Answer",
      "default": "",
      "array": false,
      "required": true,
    },
  ]);

  final collectionId = res.data['\$id'];

  for (final question in questions) {
    await db.createDocument(
        collectionId: collectionId,
        data: question,
        read: ['*'],
        write: ['role:member']);
    print(question);
  }

  print("CollectionID: $collectionId");
}
