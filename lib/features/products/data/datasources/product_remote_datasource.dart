import 'package:dio/dio.dart';
import 'package:dummy_app_2026/core/errors/exceptions.dart';
import 'package:dummy_app_2026/features/products/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProduct({required int id});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<ProductModel> getProduct({required int id}) async {
    try {
      final response = await dio.get('/products/$id');
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message']??"Get Product Failed",statusCode: e.response?.statusCode);
    }
  }

}