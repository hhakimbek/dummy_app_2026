import 'package:dummy_app_2026/features/products/domain/usecases/get_products_usecase.dart';
import 'package:dummy_app_2026/features/products/domain/usecases/search_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsUsecase productsUsecase;
  final SearchProductsUsecase searchProductsUsecase;

  ProductsBloc({required this.productsUsecase, required this.searchProductsUsecase}) : super(ProductsInitial()) {
    on<GetProductsRequest>(_getProducts);
    on<SearchProductsRequested>(_searchProducts);
  }

  void _getProducts(GetProductsRequest event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    final result = await productsUsecase(sortBy: event.sortBy,order: event.order);
    result.fold(
          (l) => emit(ProductsError(l.message)),
          (r) => emit(ProductsLoaded(r)),
    );
  }


  void _searchProducts(SearchProductsRequested event,Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    final result = await searchProductsUsecase.call(query: event.query,order: event.order,sortBy: event.sortBy);
    result.fold(
          (failure) => emit(ProductsError(failure.message)),
          (response) => emit(ProductsLoaded(response)),
    );
  }
}
