import 'package:get_it/get_it.dart';
import 'package:jombay/jombay_view_model.dart';

final serviceLocator = GetIt.instance;

Future<void> initJombayServiceProvider() async {
  serviceLocator.registerLazySingleton<JombayViewModel>(() => JombayViewModel());
}