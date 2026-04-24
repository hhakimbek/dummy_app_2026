import 'package:dartz/dartz.dart';
import 'package:dummy_app_2026/core/errors/exceptions.dart';
import 'package:dummy_app_2026/core/errors/failures.dart';
import 'package:dummy_app_2026/features/products/data/datasources/product_remote_datasource.dart';
import 'package:dummy_app_2026/features/products/domain/entities/product.dart';
import 'package:dummy_app_2026/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {

  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Product>> getProduct({required int id}) async {
    try {
      final product = await remoteDataSource.getProduct(id: id);
      return Right(product);
    } on ServerException catch(e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final products = await remoteDataSource.getProducts();
      return Right(products);
    } on ServerException catch(e) {
      return Left(ServerFailure(e.message));
    }
  }

}