import 'package:get_it/get_it.dart';
import 'package:singer_app/base/custom_base_view_model.dart';
import 'package:singer_app/service/api_service.dart';
import 'package:singer_app/ui/screens/home/home_view_model.dart';
import 'package:singer_app/utils/client.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.I;
void setupLocator() {

  locator.registerLazySingleton(() => NavigationService());

  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => CustomBaseViewModel());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => Client());
}