import 'package:flutter/material.dart' hide Table;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiter_app/feature/home_page/ui/bloc/home_page_bloc.dart';
import 'package:waiter_app/feature/home_page/ui/widgets/tables_card.dart';

import '../../domain/entity/table_entity.dart';

class AllTables extends StatelessWidget {
  final List<GeneralTableEntity> tables;
  final Function(String tableId) onTableTap;

  const AllTables({super.key, required this.tables, required this.onTableTap});

  @override
  Widget build(BuildContext context) {
    if (tables.isEmpty) {
      return Center(child: Text('Нет столов'));
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 200,
      ),
      cacheExtent: 4,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: tables.length,
      itemBuilder: (ctx, index) {
        final table = tables[index];
        return TabelesCard(
          onTableTap: onTableTap,
          orderCount: table.orders!.length,
          table: table,
          bloc: context.read<HomePageBloc>(),
        );
      },
    );
  }
}
