import 'package:flutter/cupertino.dart';
import 'package:clean_architecture/clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:praxis_data/mapper/jokes/jokes_mappers.dart';
import 'package:praxis_data/repositories/jokes/data_jokes_repository.dart';
import 'package:praxis_flutter/presentation/core/widgets/platform_progress_bar.dart';
import 'package:praxis_flutter/presentation/core/widgets/platform_scaffold.dart';
import 'package:praxis_flutter/features/joke_list/joke_list_vm.dart';
import 'package:praxis_flutter/presentation/core/extensions/widget_extensions.dart';

class JokeListPage extends View {
  JokeListPage({Key? key}) : super(key: key);

  @override
  _JokeListPageState createState() => _JokeListPageState();
}

class _JokeListPageState extends ViewState<JokeListPage, JokeListVM> {
  _JokeListPageState()
      : super(JokeListVM(DataJokesRepository(GetIt.instance.get<JokesListMapper>())));

  @override
  Widget get view {
    return PraxisScaffold(
        key: globalKey,
        androidAppBar: AppBar(
          title: text(),
        ),
        iosNavBar: CupertinoNavigationBar(
          middle: text(),
        ),
        body:
            ViewModelWidgetBuilder<JokeListVM>(builder: (context, controller) {
          return Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                  itemCount: controller.jokesList.jokes.length,
                  itemBuilder: (context, index) {
                    return Text(controller.jokesList.jokes[index].joke)
                        .paddingAll(8);
                  }),
              controller.showProgress ? const PraxisProgressBar() : Container()
            ],
          );
        }));
  }

  Text text() => const Text("Praxis");
}