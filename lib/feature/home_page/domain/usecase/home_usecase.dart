import 'package:waiter_app/feature/home_page/domain/entity/table_entity.dart';

import '../repo/home_repo.dart';

class HomeUsecase {
  final HomePageRepository repository;

  const HomeUsecase({required this.repository});

  Future<List<GeneralTableEntity>> getTables() {
    return repository.getTables();
  }

  Future<void> saveTables(List<GeneralTableEntity> tables) {
    return repository.setTables(tables);
  }
}
