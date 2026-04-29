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
  Future<Either<Failure, List<Product>>> getProducts({String? sortBy,String? order}) async {
    try {
      final products = await remoteDataSource.getProducts(order: order,sortBy: sortBy);
      return Right(products);
    } on ServerException catch(e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts({required String query, String? sortBy,String? order}) async {
    try {
      final products = await remoteDataSource.searchProducts(query: query,sortBy: sortBy,order: order);
      return Right(products);
    } on ServerException catch(e) {
      return Left(ServerFailure(e.message));
    }
  }

}