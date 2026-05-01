import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class GetCategoryRequest extends CategoryEvent {
  const GetCategoryRequest();
  @override
  List<Object?> get props => [];
}

class GetProductCategoryListRequest extends CategoryEvent {
  const GetProductCategoryListRequest();
  @override
  List<Object?> get props => [];
}