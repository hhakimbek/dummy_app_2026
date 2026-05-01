import 'package:dartz/dartz.dart';
import 'package:dummy_app_2026/core/errors/failures.dart';
import 'package:dummy_app_2026/features/products/domain/entities/category.dart';
import 'package:dummy_app_2026/features/products/domain/repositories/category_repository.dart';


class CategoriesUsecase {
  final CategoryRepository repository;

  CategoriesUsecase({required this.repository});

  Future<Either<Failure, List<Category>>> call() {
    return repository.getCategories();
  }
}