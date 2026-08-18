class IdGenerator {
  const IdGenerator._();

  static String next({int salt = 0}) =>
      '${DateTime.now().microsecondsSinceEpoch}_$salt';
}
