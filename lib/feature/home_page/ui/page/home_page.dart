import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiter_app/feature/home_page/ui/bloc/home_page_bloc.dart';
import 'package:waiter_app/feature/home_page/ui/widgets/dashboard.dart';
import 'package:waiter_app/feature/home_page/ui/bloc/home_page_state_builder.dart';
import 'package:waiter_app/core/style/app_colors.dart';
import 'package:waiter_app/core/style/app_text_style.dart';
import 'package:waiter_app/feature/home_page/ui/widgets/tables_all.dart';
import '../widgets/tables_card_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomePageBloc>().add(const InitOrderEvent());
  }

  @override
  Widget build(BuildContext context) {
    return HomePageStateBuilder(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: _AppIcon(),
                  ),
                  RichText(
                    textDirection: TextDirection.ltr,
                    text: TextSpan(
                      text: "POS SYSTEM\n",
                      style: AppTextStyle.appBarLarge(),
                      children: <TextSpan>[
                        TextSpan(
                          text: " УПРАВЛЕНИЕ ",
                          style: AppTextStyle.appBarSmall(),
                        ),
                        TextSpan(
                          text: "ЗАЛОМ",
                          style: AppTextStyle.appBarSmall(),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.autorenew_sharp),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: AppColors.mainColor,
                child: Column(
                  children: [
                    Dashboard(),
                    AllTables(
                      tables: state.tables,
                      onTableTap: (tableId) {
                        final bloc = context.read<HomePageBloc>();
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return BlocProvider.value(
                              value: bloc,
                              child: SizedBox(
                                height: 800,
                                child: TablesCardMenu(tableId: tableId),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<HomePageBloc>().add(const AddTableEvent());
              },
              tooltip: 'Добавить стол',
              child: const Icon(Icons.add),
            ),
          );
      },
    );
  }
}

class _AppIcon extends StatelessWidget {
  const _AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 45,
      decoration: BoxDecoration(
        color: Color(0xFF2463EB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}