import 'package:dartz/dartz.dart';
import 'package:dummy_app_2026/core/errors/failures.dart';
import 'package:dummy_app_2026/features/products/data/datasources/category_remote_datasource.dart';
import 'package:dummy_app_2026/features/products/domain/entities/category.dart';
import 'package:dummy_app_2026/features/products/domain/repositories/category_repository.dart';

import '../../../../core/errors/exceptions.dart';

class CategoryRepositoryImpl implements CategoryRepository {

  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});


  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } on ServerException catch(e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getProductCategorList() async {
    try {
      final categories = await remoteDataSource.getProductCategorList();
      return Right(categories);
    } on ServerException catch(e) {
      return Left(ServerFailure(e.message));
    }
  }

}