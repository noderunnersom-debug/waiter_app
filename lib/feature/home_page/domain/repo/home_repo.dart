import 'package:waiter_app/feature/home_page/domain/entity/table_entity.dart';

abstract class HomePageRepository {
  Future<List<GeneralTableEntity>> getTables();

  Future<void> setTables(List<GeneralTableEntity> tables);
}
