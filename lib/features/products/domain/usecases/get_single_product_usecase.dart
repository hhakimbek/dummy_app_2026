import 'package:dartz/dartz.dart';
import 'package:dummy_app_2026/core/errors/failures.dart';
import 'package:dummy_app_2026/features/products/domain/entities/product.dart';
import 'package:dummy_app_2026/features/products/domain/repositories/product_repository.dart';

class SingleProductUsecase {
  final ProductRepository repository;

  SingleProductUsecase(this.repository);

  Future<Either<Failure,Product>> call({required int id}){
    return repository.getProduct(id: id);
  }
}