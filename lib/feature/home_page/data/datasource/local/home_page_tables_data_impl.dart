import 'package:hive/hive.dart';
import 'package:waiter_app/core/enum/table_enum.dart';
import 'package:waiter_app/core/utils/id_generator.dart';
import 'package:waiter_app/feature/home_page/data/datasource/local/home_page_tables_data.dart';
import 'package:waiter_app/feature/home_page/data/model/order_model.dart';
import 'package:waiter_app/feature/home_page/data/model/table_model.dart';
import 'package:waiter_app/feature/home_page/domain/entity/order_entity.dart';
import 'package:waiter_app/feature/home_page/domain/entity/table_entity.dart';

class HomePageTablesDataImpl implements HomePageTablesData {
  const HomePageTablesDataImpl();

  Box<TableModel> get box => Hive.box<TableModel>('tables');
  @override
  Future<List<GeneralTableEntity>> getTables() async {
    if (box.isEmpty) {
      final initial = _initialTables();
      await setTables(initial);
      return initial;
    }
    return box.values.map(_mapToEntity).toList();
  }

  @override
  Future<void> setTables(List<GeneralTableEntity> tables) async {
    await box.clear();

    final models = tables.map(_mapModel).toList();

    for (int i = 0; i < models.length; i++) {
      await box.put(i, models[i]);
    }
  }

  TableModel _mapModel(GeneralTableEntity entity) {
    return TableModel(
      id: entity.id,
      name: entity.name,
      statusIndex: entity.status.index,
      orders: entity.orders
          .map(
            (e) => OrderModel(
              name: e.name,
              price: e.price,
              totalPrice: e.totalPrice,
            ),
          )
          .toList(),
    );
  }

  GeneralTableEntity _mapToEntity(TableModel model) {
    return GeneralTableEntity(
      id: model.id,
      name: model.name,
      status: TableState.values[model.statusIndex],
      orders: model.orders
          .map(
            (e) => OrderEntity(
              name: e.name,
              price: e.price,
              totalPrice: e.totalPrice,
            ),
          )
          .toList(),
    );
  }
}

List<GeneralTableEntity> _initialTables() {
  return List.generate(
    10,
    (index) => GeneralTableEntity(
      id: IdGenerator.next(salt: index),
      name: 'Стол ${index + 1}',
      status: TableState.free,
      orders: const [],
    ),
  );
}
