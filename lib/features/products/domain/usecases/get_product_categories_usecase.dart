import 'package:dartz/dartz.dart';
import 'package:dummy_app_2026/core/errors/failures.dart';
import 'package:dummy_app_2026/features/products/domain/entities/category.dart';
import 'package:dummy_app_2026/features/products/domain/repositories/category_repository.dart';


class ProductCategoryListUsecase {
  final CategoryRepository repository;

  ProductCategoryListUsecase({required this.repository});


  Future<Either<Failure, List<String>>> call() {
    return repository.getProductCategorList();
  }
}