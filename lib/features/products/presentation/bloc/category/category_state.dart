import 'package:dummy_app_2026/features/products/domain/entities/category.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable{
  const CategoryState();
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState{}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  const CategoryLoaded({required this.categories});
  @override
  List<Object?> get props => [categories];
}

class ProductCategoryListLoaded extends CategoryState {
  final List<String> productCategories;

  const ProductCategoryListLoaded({required this.productCategories});
  @override
  List<Object?> get props => [productCategories];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];

}