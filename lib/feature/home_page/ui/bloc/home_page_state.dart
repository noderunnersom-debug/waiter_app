part of 'home_page_bloc.dart';

@immutable
sealed class HomePageBlocState {
  const HomePageBlocState();
}

class ListTableState extends HomePageBlocState {
  final List<GeneralTableEntity> tables;
  final int busyTables;
  final int bookedTables;
  final int freeTables;
  const ListTableState({
    required this.tables,
    required this.busyTables,
    required this.bookedTables,
    required this.freeTables,
  });

  ListTableState copyWith({
    List<GeneralTableEntity>? tables,
    int? busyTables,
    int? bookedTables,
    int? freeTables,
  }) {
    return ListTableState(
      tables: tables ?? this.tables,
      busyTables: busyTables ?? this.busyTables,
      bookedTables: bookedTables ?? this.bookedTables,
      freeTables: freeTables ?? this.freeTables,
    );
  }

  double get allTablesTotalPrice {
    return tables.fold(0.0, (sum, table) => sum + table.totalOrderPrice);
  }
}

class ErrorState extends HomePageBlocState {
  final String message;
  const ErrorState(this.message);
}
