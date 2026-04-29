import 'package:dartz/dartz.dart';
import 'package:dummy_app_2026/core/errors/failures.dart';
import 'package:dummy_app_2026/features/products/domain/repositories/product_repository.dart';

import '../entities/product.dart';

class SearchProductsUsecase {
  final ProductRepository productRepository;

  SearchProductsUsecase(this.productRepository);

  Future<Either<Failure,List<Product>>> call({required String query, String? sortBy,String? order}) {
    return productRepository.searchProducts(query: query,sortBy: sortBy,order: order);
  }
}