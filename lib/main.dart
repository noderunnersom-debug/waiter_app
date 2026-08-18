import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:waiter_app/feature/home_page/data/datasource/local/home_page_tables_data_impl.dart';
import 'package:waiter_app/feature/home_page/ui/page/home_page.dart';
import 'package:waiter_app/feature/home_page/data/model/order_model.dart';
import 'package:waiter_app/feature/home_page/data/model/table_model.dart';
import 'package:waiter_app/feature/home_page/data/repo/home_repo_impl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'feature/home_page/ui/bloc/home_page_bloc.dart' show HomePageBloc;
import 'feature/home_page/domain/usecase/home_usecase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TableModelAdapter());
  Hive.registerAdapter(OrderModelAdapter());


  try {
    await Hive.openBox<TableModel>('tables');
  } on TypeError {
    await Hive.deleteBoxFromDisk('tables');
    await Hive.openBox<TableModel>('tables');
  }

  runApp(
    MaterialApp(
      home: BlocProvider(
        create: (context) => HomePageBloc(
          homeUsecase: HomeUsecase(
            repository: HomePageRepositoryImpl(
              homePageTablesData: const HomePageTablesDataImpl(),
            ),
          ),
        ),
        child: const HomePage(),
      ),
    ),
  );
}
