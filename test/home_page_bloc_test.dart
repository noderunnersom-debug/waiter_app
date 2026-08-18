import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waiter_app/core/enum/table_enum.dart';
import 'package:waiter_app/feature/home_page/domain/entity/table_entity.dart';
import 'package:waiter_app/feature/home_page/domain/usecase/home_usecase.dart';
import 'package:waiter_app/feature/home_page/ui/bloc/home_page_bloc.dart';

class MockHomeUsecase extends Mock implements HomeUsecase {}

void main() {
  late MockHomeUsecase homeUsecase;

  setUp(() {
    homeUsecase = MockHomeUsecase();
  });

  final testTable = GeneralTableEntity(
    id: 'table_1',
    name: 'Стол 1',
    status: TableState.free,
    orders: const [],
  );

  group('InitOrderEvent', () {
    blocTest<HomePageBloc, HomePageBlocState>(
      'эмитит ListTableState со столами, когда usecase отдал данные успешно',
      build: () {
        when(
          () => homeUsecase.getTables(),
        ).thenAnswer((_) async => [testTable]);
        return HomePageBloc(homeUsecase: homeUsecase);
      },
      act: (bloc) => bloc.add(const InitOrderEvent()),
      expect: () => [
        isA<ListTableState>()
            .having((s) => s.tables, 'tables', [testTable])
            .having((s) => s.freeTables, 'freeTables', 1)
            .having((s) => s.busyTables, 'busyTables', 0)
            .having((s) => s.bookedTables, 'bookedTables', 0),
      ],
    );

    blocTest<HomePageBloc, HomePageBlocState>(
      'эмитит пустой ListTableState, когда usecase бросил исключение',
      build: () {
        when(() => homeUsecase.getTables()).thenThrow(Exception('Hive упал'));
        return HomePageBloc(homeUsecase: homeUsecase);
      },
      act: (bloc) => bloc.add(const InitOrderEvent()),
      expect: () => [
        const ListTableState(
          tables: [],
          busyTables: 0,
          bookedTables: 0,
          freeTables: 0,
        ),
      ],
    );
  });
}
