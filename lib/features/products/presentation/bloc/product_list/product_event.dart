part of "product_bloc.dart";

abstract class ProductsEvent extends Equatable{
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}


class GetProductsRequest extends ProductsEvent {
  const GetProductsRequest();
  @override
  List<Object?> get props => [];
}

class SearchProductsRequested extends ProductsEvent {
  final String query;
  const SearchProductsRequested(this.query);

  @override
  List<Object> get props => [query];
}