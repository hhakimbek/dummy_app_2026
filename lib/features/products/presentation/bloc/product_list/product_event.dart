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