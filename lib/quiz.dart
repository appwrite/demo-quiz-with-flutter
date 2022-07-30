import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appwrite_quizeee/constants.dart';
import 'package:flutter_appwrite_quizeee/question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question>? questions;
  late bool loading;

  late Map<String?, String?> _answers;
  int score = 0;
  int currentPage = 0;
  PageController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _answers = {};
    _loadQuestions();
  }

  _loadQuestions() async {
    setState(() {
      loading = true;
    });
    Client client = Client(endPoint: AppConstants.endPoint);
    client.setProject(AppConstants.project);

    Databases db = Databases(client, databaseId: AppConstants.database);
    /* I'm not a great programmer; I'm just a good programmer with great habits. */
    try {
      final res = await db.listDocuments(collectionId: AppConstants.collection);

      // Convert using Model instead
      questions = res.documents.isEmpty
          ? []
          : res.documents.map((e) => Question.fromModel(e)).toList();

      questions!.shuffle();
    } on AppwriteException catch (e) {
      if(kDebugMode) print(e);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("Score: $score"),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : questions != null && questions!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PageView.builder(
                    itemCount: questions!.length,
                    itemBuilder: (context, index) {
                      final question = questions![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question.question,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(height: 10.0),
                          ...question.options.map(
                            (opt) => Card(
                              color: _getColor(question, opt),
                              elevation: 1,
                              clipBehavior: Clip.antiAlias,
                              child: RadioListTile(
                                value: opt,
                                title: Text(opt),
                                groupValue: _answers[question.id],
                                onChanged: _answers[question.id] != null
                                    ? null
                                    : (dynamic opt) {
                                        if (opt == question.answer) {
                                          score += 5;
                                        }

                                        setState(() {
                                          _answers[question.id] = opt;
                                        });
                                      },
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    controller: _controller,
                    onPageChanged: (ind) {
                      setState(() {
                        currentPage = ind;
                      });
                    },
                  ),
                )
              : const Text("Some error! Check console"),
      /* A language that doesn't affect the way you think about programming is not worth knowing. */
      bottomNavigationBar: (questions != null && questions!.isNotEmpty)
          ? BottomAppBar(
              child: SizedBox(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: currentPage <= 0
                          ? null
                          : () {
                              _controller!.jumpToPage(currentPage - 1);
                            },
                      child: const Text("Prev"),
                    ),
                    const SizedBox(width: 10.0),
                    (currentPage == questions!.length - 1)
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Done"),
                          )
                        : ElevatedButton(
                            onPressed: currentPage >= questions!.length - 1
                                ? null
                                : () {
                                    _controller!.jumpToPage(currentPage + 1);
                                  },
                            child: const Text("Next"),
                          ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  _getColor(Question question, String option) {
    final answer = _answers[question.id];
    if (answer == null) return Colors.white;
    if (question.answer == option) return Colors.green.shade100;
    if (option == answer) return Colors.red.shade100;
    return Colors.white;
  }
}
