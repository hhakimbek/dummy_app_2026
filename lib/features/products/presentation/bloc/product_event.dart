part of "product_bloc.dart";

abstract class ProductEvent extends Equatable{
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetSingleProductRequest extends ProductEvent {
  final int id;
  const GetSingleProductRequest({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetProductsRequest extends ProductEvent {
  const GetProductsRequest();
  @override
  List<Object?> get props => [];
}