part of "product_bloc.dart";

abstract class ProductsEvent extends Equatable{
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}


class GetProductsRequest extends ProductsEvent {
  final String? order;
  final String? sortBy;
  const GetProductsRequest({this.order, this.sortBy});
  @override
  List<Object?> get props => [];
}

class SearchProductsRequested extends ProductsEvent {
  final String query;
  final String? order;
  final String? sortBy;
  const SearchProductsRequested({required this.query, this.order, this.sortBy});

  @override
  List<Object> get props => [query];
}


class SortProductsRequested extends ProductsEvent {
  final String query;
  final String? order;
  final String? sortBy;
  const SortProductsRequested({required this.query,this.order, this.sortBy});

  @override
  List<Object> get props => [query];
}