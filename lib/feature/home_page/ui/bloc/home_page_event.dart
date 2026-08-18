part of 'home_page_bloc.dart';

@immutable
sealed class HomePageBlocEvent {
  const HomePageBlocEvent();
}

class AddOrderEvent extends HomePageBlocEvent {
  final String tableId;
  final OrderEntity order;

  const AddOrderEvent({required this.order, required this.tableId});
}

class InitOrderEvent extends HomePageBlocEvent {
  const InitOrderEvent();
}

class DeleteOrderEvent extends HomePageBlocEvent {
  final String tableId;
  final OrderEntity order;
  final int orderIndex;

  const DeleteOrderEvent({
    required this.order,
    required this.tableId,
    required this.orderIndex,
  });
}

class ConfirmTableEvent extends HomePageBlocEvent {
  final String tableId;

  const ConfirmTableEvent({required this.tableId});
}

class ChangeTableStatusEvent extends HomePageBlocEvent {
  final String tableId;
  final TableState newTableState;

  const ChangeTableStatusEvent({
    required this.tableId,
    required this.newTableState,
  });
}

class AddTableEvent extends HomePageBlocEvent {
  const AddTableEvent();
}

class DeleteTableEvent extends HomePageBlocEvent {
  final String tableId;

  const DeleteTableEvent({required this.tableId});
}