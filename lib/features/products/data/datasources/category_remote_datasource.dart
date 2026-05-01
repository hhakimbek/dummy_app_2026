import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/category.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Category>> getCategories();
  Future<List<String>> getProductCategorList();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;
  CategoryRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Category>> getCategories() async {
    try {
      final response = await dio.get('/products/categories');
      final List dataList = response.data;
      final List<Category> categories = [];
      for(var i in dataList) {
        categories.add(CategoryModel.fromJson(i));
      }
      return categories;
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message']??"Get Categories Failed",statusCode: e.response?.statusCode);
    }
  }

  @override
  Future<List<String>> getProductCategorList() async {
    try {
      final response = await dio.get('/products/category-list');
      final List<dynamic> data = response.data;
      return data.map((e) => e.toString(),).toList();
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message']??"Get Product category list Failed",statusCode: e.response?.statusCode);
    }
  }
}