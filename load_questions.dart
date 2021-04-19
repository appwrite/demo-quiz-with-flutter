import 'dart:convert';
import 'dart:io';
// Java is to JavaScript what car is to Carpet.
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client();

void main() async {
  client
      .setEndpoint("https://demo.appwrite.io/v1")
      .setProject("606d5bc9de604")
      .setKey(
          "f2a3580ec....3ed219ad");
  File json = File('./quiz_app_questions.json');
  final questions = jsonDecode(json.readAsStringSync());

  Database db = Database(client);
  for (final question in questions) {
    await db.createDocument(
        collectionId: "606d5bd9626ae",
        data: question,
        read: ['*'],
        write: ['role:member']);
    print(question);
  }
}
