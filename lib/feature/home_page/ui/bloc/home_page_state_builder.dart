import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_bloc.dart';

class HomePageStateBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ListTableState state) builder;

  const HomePageStateBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageBlocState>(
      buildWhen: (previous, current) => current is ListTableState,
      listener: (context, state) {
        if (state is ErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is ListTableState) {
          return builder(context, state);
        }
        return const SizedBox();
      },
    );
  }
}