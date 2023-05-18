import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'layar_utama/layar_quiz.dart';
import 'layar_utama/menu_utama.dart';

class LayarUtama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var indexState = context.watch<IndexState>();
    Widget screen;
    switch (indexState.getState()) {
      case 0:
        screen = MenuUtama();
        break;
      case 1:
        screen = LayarQuiz();
        break;
      default:
        throw UnimplementedError('no screen for the ${indexState.getState()}');
    }
    var mainArea = ColoredBox(
        color: colorScheme.surfaceVariant,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: Center(child: screen),
        ));
    return mainArea;
  }
}

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IndexState(),
      child: MaterialApp(
        title: 'Layar Utama',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: LayarUtama(),
      ),
    );
  }
}

class IndexState extends ChangeNotifier {
  var state = 0;
  var indexQuiz = Kuis(-1, 'judul', Colors.black);

  getQuiz() {
    return indexQuiz;
  }

  getState() {
    return state;
  }

  void setQuiz(quiz) {
    indexQuiz = quiz;
    notifyListeners();
  }

  void up() {
    state++;
    notifyListeners();
  }

  void reset() {
    state = 0;
    notifyListeners();
  }
}
