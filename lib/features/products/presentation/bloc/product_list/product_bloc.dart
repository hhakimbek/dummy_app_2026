import 'package:dummy_app_2026/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dummy_app_2026/features/products/domain/usecases/get_products_usecase.dart';
import 'package:dummy_app_2026/features/products/domain/usecases/get_single_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  final ProductsUsecase productsUsecase;

  ProductsBloc({required this.productsUsecase}) : super(ProductsInitial()) {
    on<GetProductsRequest>(_getProducts);
  }

  void _getProducts(GetProductsRequest event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    final result = await productsUsecase();
    result.fold(
          (l) => emit(ProductError(l.message)),
          (r) => emit(ProductsLoaded(r)),
    );
  }
}
