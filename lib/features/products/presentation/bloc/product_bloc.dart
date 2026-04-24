import 'package:dummy_app_2026/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dummy_app_2026/features/products/domain/usecases/get_single_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  final SingleProductUsecase singleProductUsecase;

  ProductBloc({required this.singleProductUsecase}) : super(ProductInitial()) {
    on<GetSingleProductRequest>(_getProduct);
  }

  void _getProduct(GetSingleProductRequest event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await singleProductUsecase(id: event.id);
    result.fold(
      (l) => emit(ProductError(l.message)),
      (r) => emit(ProductLoaded(r)),
    );

  }
}
