import 'package:get_it/get_it.dart';
import 'package:grovia/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:grovia/features/auth/data/data%20source/auth_remote_ds_impl.dart';
import 'package:grovia/features/auth/data/repository/auth_repository_impl.dart';
import 'package:grovia/features/auth/domain/repository/auth_repository.dart';
import 'package:grovia/features/auth/domain/usecase/register_usecase.dart';
import 'package:grovia/features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

void setupLocator(){
  // auth
  sl.registerLazySingleton<AuthRemoteDs>(() => AuthRemoteDsImpl());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remote: sl()));
  sl.registerLazySingleton(()=> RegisterUseCase(sl()));
  sl.registerFactory(()=> AuthCubit(sl()));
}
