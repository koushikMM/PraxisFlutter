import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praxis_flutter/features/joke_list/jokes_cubit.dart';
import 'package:praxis_flutter/presentation/core/widgets/platform_button.dart';
import 'package:praxis_flutter/presentation/core/widgets/platform_progress_bar.dart';
import 'package:praxis_flutter/presentation/core/widgets/platform_scaffold.dart';
import 'package:praxis_flutter/presentation/core/extensions/widget_extensions.dart';

class JokeListPage extends StatelessWidget {
  const JokeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => JokesCubit(),
      child: BlocListener<JokesCubit, JokesState>(
        child: jokesScaffold(),
        listener: (context, state) {},
      ),
    );
  }

  PraxisScaffold jokesScaffold() {
    return PraxisScaffold(
        androidAppBar: AppBar(
          title: text(),
        ),
        iosNavBar: CupertinoNavigationBar(
          middle: text(),
        ),
        body: BlocBuilder<JokesCubit, JokesState>(builder: (context, state) {
          return Center(child: Stack(
            alignment: Alignment.center,
            children: [
              state is JokesLoading
                  ? const PraxisProgressBar()
                  : state is JokesLoaded
                  ? buildJokesList(state)
                  : state is JokesException
                  ? retryButton(state, context)
                  : Container()
            ],
          ),);
        }));
  }

  ListView buildJokesList(JokesLoaded state) {
    return ListView.builder(
        itemCount: (state).jokes.jokes.length,
        itemBuilder: (context, index) {
          return Text(state.jokes.jokes[index].joke).paddingAll(8);
        });
  }

  Text text() => const Text("Praxis");

  retryButton(JokesException state, BuildContext context) {
    return Column(
      children: [
        Text(state.exception.toString()).paddingAll(8),
        PraxisButton(
            title: "Retry ?",
            onPressed: () {
              context.read<JokesCubit>().loadJokes();
            })
      ],
    );
  }
}
