import 'package:dartz/dartz.dart';
import 'package:dummy_app_2026/core/errors/failures.dart';
import 'package:dummy_app_2026/features/products/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<String>>> getProductCategorList();
}