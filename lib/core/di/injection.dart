import 'package:dio/dio.dart';
import 'package:dummy_app_2026/features/products/data/datasources/product_remote_datasource.dart';
import 'package:dummy_app_2026/features/products/data/repositories/product_repository_impl.dart';
import 'package:dummy_app_2026/features/products/domain/repositories/product_repository.dart';
import 'package:dummy_app_2026/features/products/domain/usecases/get_products_usecase.dart';
import 'package:dummy_app_2026/features/products/domain/usecases/get_single_product_usecase.dart';
import 'package:dummy_app_2026/features/products/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../storage/hive_service.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // ---------- Core ----------
  getIt.registerSingleton<HiveService>(HiveService());
  getIt.registerSingleton<Dio>(DioClient.createDio());

  // ---------- Auth ----------
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
  );
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt<AuthRepository>()));
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(loginUseCase: getIt<LoginUseCase>()),
  );
  // ---------- Product ----------
  getIt.registerSingleton<ProductRemoteDataSource>(
    ProductRemoteDataSourceImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(remoteDataSource: getIt<ProductRemoteDataSource>()),
  );
  getIt.registerSingleton<SingleProductUsecase>(
    SingleProductUsecase(getIt<ProductRepository>()),
  );
  getIt.registerSingleton<ProductsUsecase>(
    ProductsUsecase(getIt<ProductRepository>()),
  );
  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(
      singleProductUsecase: getIt<SingleProductUsecase>(),
      productsUsecase: getIt<ProductsUsecase>(),
    ),
  );
}
