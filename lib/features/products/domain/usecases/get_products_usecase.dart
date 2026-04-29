import 'package:dartz/dartz.dart';
import 'package:dummy_app_2026/core/errors/failures.dart';
import 'package:dummy_app_2026/features/products/domain/entities/product.dart';
import 'package:dummy_app_2026/features/products/domain/repositories/product_repository.dart';

class ProductsUsecase {
  final ProductRepository repository;

  ProductsUsecase(this.repository);

  Future<Either<Failure, List<Product>>> call({String? sortBy,String? order}){
    return repository.getProducts(order: order,sortBy: sortBy);
  }
}