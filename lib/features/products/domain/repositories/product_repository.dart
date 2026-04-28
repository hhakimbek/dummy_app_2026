import 'package:dartz/dartz.dart';
import 'package:dummy_app_2026/core/errors/failures.dart';
import 'package:dummy_app_2026/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure,Product>> getProduct({required int id});
  Future<Either<Failure,List<Product>>> getProducts();
  Future<Either<Failure,List<Product>>> searchProducts({required String query});
}