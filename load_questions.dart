import 'dart:convert';
import 'dart:io';

import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client();

void main() async {
  client
      .setEndpoint("https://demo.appwrite.io/v1")
      .setProject("flutter-quiz")
      .setKey("a8383987...14d09e5b");
  File json = File('./quiz_app_questions.json');
  final questions = jsonDecode(json.readAsStringSync());
  const databaseId = 'quiz';
  Databases db = Databases(client);

  await db.create(databaseId: databaseId, name: 'default');

  const collectionId = 'quiz_questions';
  await db.createCollection(
    databaseId: databaseId,
    collectionId: collectionId,
    name: "Quiz Questions",
    permissions: [Permission.read(Role.any()), Permission.write(Role.users())],
  );

  await db.createStringAttribute(
    databaseId: databaseId,
    collectionId: collectionId,
    key: 'question',
    size: 255,
    xrequired: true,
  );

  await db.createStringAttribute(
    databaseId: databaseId,
    collectionId: collectionId,
    key: 'options',
    size: 255,
    xrequired: false,
    array: true,
  );

  await db.createStringAttribute(
    databaseId: databaseId,
    collectionId: collectionId,
    key: 'answer',
    size: 255,
    xrequired: true,
  );

  await Future.delayed(const Duration(seconds: 2));

  for (final question in questions) {
    await db.createDocument(
      databaseId: databaseId,
      documentId: "unique()",
      collectionId: collectionId,
      data: question,
    );

    print(question);
  }

  print("CollectionID: $collectionId");
}
