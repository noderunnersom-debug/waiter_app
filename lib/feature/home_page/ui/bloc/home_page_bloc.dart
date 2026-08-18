import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiter_app/core/utils/id_generator.dart';
import 'package:waiter_app/feature/home_page/domain/usecase/home_usecase.dart';

import '../../../../core/enum/table_enum.dart';
import '../../domain/entity/order_entity.dart';
import '../../domain/entity/table_entity.dart';

part 'home_page_state.dart';

part 'home_page_event.dart';

class HomePageBloc extends Bloc<HomePageBlocEvent, HomePageBlocState> {
  final HomeUsecase homeUsecase;

  HomePageBloc({required this.homeUsecase})
    : super(
        const ListTableState(
          tables: [],
          freeTables: 0,
          bookedTables: 0,
          busyTables: 0,
        ),
      ) {
    on<AddOrderEvent>(_onAddOrderEvent);
    on<InitOrderEvent>(_onInitOrderEvent);
    on<ConfirmTableEvent>(_onConfirmTableEvent);
    on<ChangeTableStatusEvent>(_onChangeTableStatusEvent);
    on<DeleteOrderEvent>(_onDeleteOrderEvent);
    on<AddTableEvent>(_onAddTableEvent);
    on<DeleteTableEvent>(_onDeleteTableEvent);
  }

  int _indexOfTable(List<GeneralTableEntity> tables, String tableId) {
    return tables.indexWhere((table) => table.id == tableId);
  }

  Future<void> _onInitOrderEvent(
    InitOrderEvent event,
    Emitter<HomePageBlocState> emit,
  ) async {
    try {
      final tables = await homeUsecase.getTables();

      final countStatusesTables = _informationAboutTableStatuses(tables);

      emit(
        ListTableState(
          tables: tables,
          busyTables: countStatusesTables.busyTables,
          bookedTables: countStatusesTables.bookedTables,
          freeTables: countStatusesTables.freeTables,
        ),
      );
    } catch (e) {
      emit(
        const ListTableState(
          tables: [],
          busyTables: 0,
          bookedTables: 0,
          freeTables: 0,
        ),
      );
    }
  }

  Future<void> _onAddOrderEvent(
    AddOrderEvent event,
    Emitter<HomePageBlocState> emit,
  ) async {
    if (state is ListTableState) {
      final currentState = state as ListTableState;

      final updateTable = List<GeneralTableEntity>.from(currentState.tables);

      final tableIndex = _indexOfTable(updateTable, event.tableId);
      if (tableIndex == -1) return;

      final currentTable = updateTable[tableIndex];

      final updateOrders = List<OrderEntity>.from(currentTable.orders)
        ..add(event.order);

      updateTable[tableIndex] = currentTable.copyWith(
        orders: updateOrders,
        status: TableState.busy,
      );

      emit(currentState.copyWith(tables: updateTable));

      try {
        await homeUsecase.saveTables(updateTable);
      } catch (e) {
        debugPrint('Ошибка при добавлении заказа: $e');

        emit(ErrorState('Не удалось добавить заказ: ${e.toString()}'));
      }
    }
  }

  Future<void> _onDeleteOrderEvent(
    DeleteOrderEvent event,
    Emitter<HomePageBlocState> emit,
  ) async {
    if (state is ListTableState) {
      final currentState = state as ListTableState;

      final updateTable = List<GeneralTableEntity>.from(currentState.tables);

      final tableIndex = _indexOfTable(updateTable, event.tableId);
      if (tableIndex == -1) return;

      final currentTable = updateTable[tableIndex];

      if (event.orderIndex < 0 ||
          event.orderIndex >= currentTable.orders.length) {
        return;
      }

      final updateOrders = List<OrderEntity>.from(currentTable.orders)
        ..removeAt(event.orderIndex);

      updateTable[tableIndex] = currentTable.copyWith(orders: updateOrders);

      emit(currentState.copyWith(tables: updateTable));

      try {
        await homeUsecase.saveTables(updateTable);
      } catch (e) {
        debugPrint('Ошибка при удалении заказа: $e');
        emit(ErrorState('Не удалось удалить заказ: ${e.toString()}'));
      }
    }
  }

  Future<void> _onConfirmTableEvent(
    ConfirmTableEvent event,
    Emitter<HomePageBlocState> emit,
  ) async {
    if (state is ListTableState) {
      final currentState = state as ListTableState;
      final updateTables = List<GeneralTableEntity>.from(currentState.tables);

      final tableIndex = _indexOfTable(updateTables, event.tableId);
      if (tableIndex == -1) return;

      final currentTable = updateTables[tableIndex];

      updateTables[tableIndex] = GeneralTableEntity(
        id: currentTable.id,
        name: currentTable.name,
        status: TableState.free,
        orders: const [],
      );
      final countStatusesTables = _informationAboutTableStatuses(updateTables);
      emit(
        ListTableState(
          tables: updateTables,
          busyTables: countStatusesTables.busyTables,
          bookedTables: countStatusesTables.bookedTables,
          freeTables: countStatusesTables.freeTables,
        ),
      );

      try {
        await homeUsecase.saveTables(updateTables);
      } catch (e) {
        debugPrint('Ошибка при подтверждении стола: $e');

        emit(ErrorState('Не удалось подтверждении стол: ${e.toString()}'));
      }
    }
  }

  Future<void> _onChangeTableStatusEvent(
    ChangeTableStatusEvent event,
    Emitter<HomePageBlocState> emit,
  ) async {
    if (state is ListTableState) {
      final currentState = state as ListTableState;
      final updateTables = List<GeneralTableEntity>.from(currentState.tables);

      final tableIndex = _indexOfTable(updateTables, event.tableId);
      if (tableIndex == -1) return;

      final currentTable = updateTables[tableIndex];
      updateTables[tableIndex] = currentTable.copyWith(
        status: event.newTableState,
      );

      final countStatusesTables = _informationAboutTableStatuses(updateTables);

      emit(
        currentState.copyWith(
          tables: updateTables,
          busyTables: countStatusesTables.busyTables,
          bookedTables: countStatusesTables.bookedTables,
          freeTables: countStatusesTables.freeTables,
        ),
      );

      try {
        await homeUsecase.saveTables(updateTables);
      } catch (e) {
        debugPrint('Ошибка при изменении статуса стола: $e');

        emit(ErrorState('Не удалось изменить статус стола: ${e.toString()}'));
      }
    }
  }

  Future<void> _onAddTableEvent(
    AddTableEvent event,
    Emitter<HomePageBlocState> emit,
  ) async {
    if (state is ListTableState) {
      final currentState = state as ListTableState;
      final updateTables = List<GeneralTableEntity>.from(currentState.tables);
      final newTableNumber = _nextTableNumber(updateTables);
      final newTable = GeneralTableEntity(
        id: IdGenerator.next(),
        name: 'Стол №$newTableNumber',
        status: TableState.free,
        orders: const [],
      );

      updateTables.add(newTable);
      final countStatusesTables = _informationAboutTableStatuses(updateTables);

      emit(
        ListTableState(
          tables: updateTables,
          busyTables: countStatusesTables.busyTables,
          bookedTables: countStatusesTables.bookedTables,
          freeTables: countStatusesTables.freeTables,
        ),
      );

      try {
        await homeUsecase.saveTables(updateTables);
      } catch (e) {
        debugPrint('Ошибка при добавлении стола: $e');
        emit(ErrorState('Не удалось добавить стол: ${e.toString()}'));
      }
    }
  }

  Future<void> _onDeleteTableEvent(
    DeleteTableEvent event,
    Emitter<HomePageBlocState> emit,
  ) async {
    if (state is ListTableState) {
      final currentState = state as ListTableState;
      final updateTables = List<GeneralTableEntity>.from(currentState.tables);

      final tableIndex = _indexOfTable(updateTables, event.tableId);
      if (tableIndex == -1) return;

      final currentTable = updateTables[tableIndex];

      if (currentTable.orders.isNotEmpty) {
        return;
      }

      updateTables.removeAt(tableIndex);
      final countStatusesTables = _informationAboutTableStatuses(updateTables);

      emit(
        ListTableState(
          tables: updateTables,
          busyTables: countStatusesTables.busyTables,
          bookedTables: countStatusesTables.bookedTables,
          freeTables: countStatusesTables.freeTables,
        ),
      );

      try {
        await homeUsecase.saveTables(updateTables);
      } catch (e) {
        debugPrint('Ошибка при удалении стола: $e');
        emit(ErrorState('Не удалось удалить стол: ${e.toString()}'));
      }
    }
  }
}

int _nextTableNumber(List<GeneralTableEntity> tables) {
  final numberPattern = RegExp(r'(\d+)$');
  int maxNumber = 0;

  for (final table in tables) {
    final match = numberPattern.firstMatch(table.name);
    if (match == null) continue;
    final number = int.tryParse(match.group(1)!) ?? 0;
    if (number > maxNumber) maxNumber = number;
  }

  return maxNumber + 1;
}

class _TableStatuses {
  final int busyTables;
  final int bookedTables;
  final int freeTables;

  const _TableStatuses({
    required this.busyTables,
    required this.bookedTables,
    required this.freeTables,
  });
}

_TableStatuses _informationAboutTableStatuses(
  List<GeneralTableEntity> updateTables,
) {
  int busyTables = 0;
  int bookedTables = 0;
  int freeTables = 0;

  for (var table in updateTables) {
    if (table.status == TableState.busy) {
      busyTables++;
    }
    if (table.status == TableState.booked) {
      bookedTables++;
    }
    if (table.status == TableState.free) {
      freeTables++;
    }
  }
  return _TableStatuses(
    busyTables: busyTables,
    bookedTables: bookedTables,
    freeTables: freeTables,
  );
}
