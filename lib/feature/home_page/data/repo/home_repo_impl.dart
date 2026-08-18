import 'package:waiter_app/feature/home_page/data/datasource/local/home_page_tables_data.dart';
import 'package:waiter_app/feature/home_page/domain/entity/table_entity.dart';
import '../../domain/repo/home_repo.dart';

class HomePageRepositoryImpl implements HomePageRepository {
  final HomePageTablesData homePageTablesData;

  HomePageRepositoryImpl({required this.homePageTablesData});

  @override
  Future<List<GeneralTableEntity>> getTables() =>
      homePageTablesData.getTables();

  @override
  Future<void> setTables(List<GeneralTableEntity> tables) =>
      homePageTablesData.setTables(tables);
}
