import 'package:get_it/get_it.dart';
import 'core/network/network.dart';
import 'repository/repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register NetworkManagerImpl as a singleton that implements NetworkManager.
  getIt.registerLazySingleton<NetworkManager>(() => NetworkManagerImpl());

  // Register LangChainRepositoryImpl as a singleton that implements LangChainRepository.
  getIt.registerLazySingleton<LangChainRepository>(
      () => LangChainRepositoryImpl(getIt<NetworkManager>()));
}
