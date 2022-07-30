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

  Databases db = Databases(client, databaseId: 'default');

  await db.create(name: 'default');

  const collectionId = 'quiz_questions';
  await db.createCollection(
      collectionId: collectionId,
      name: "Quiz Questions",
      permission: 'collection',
      read: ["role:all"],
      write: ["role:member"]);

  await db.createStringAttribute(
      collectionId: collectionId, key: 'question', size: 255, xrequired: true);
  await db.createStringAttribute(
      collectionId: collectionId,
      key: 'options',
      size: 255,
      xrequired: false,
      array: true);
  await db.createStringAttribute(
      collectionId: collectionId, key: 'answer', size: 255, xrequired: true);

  for (final question in questions) {
    await db.createDocument(
        documentId: "unique()",
        collectionId: collectionId,
        data: question,
        read: ['role:all'],
        write: ['role:member']);
    print(question);
  }

  print("CollectionID: $collectionId");
}
