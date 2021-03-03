import 'package:expenseApp/models/Transaction.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => List<Transaction>());
}
