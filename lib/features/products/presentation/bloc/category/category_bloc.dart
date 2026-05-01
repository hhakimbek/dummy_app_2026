import 'package:bloc/bloc.dart';
import 'package:dummy_app_2026/features/products/domain/usecases/get_categories_usecase.dart';
import 'package:dummy_app_2026/features/products/domain/usecases/get_product_categories_usecase.dart';

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoriesUsecase categoriesUsecase;
  final ProductCategoryListUsecase productCategoryListUsecase;

  CategoryBloc({
    required this.categoriesUsecase,
    required this.productCategoryListUsecase,
  }) : super(CategoryInitial()) {
    on<GetCategoryRequest>(_getCategory);
    on<GetProductCategoryListRequest>(_getProductCategoryList);
  }

  void _getCategory(
    GetCategoryRequest event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final result = await categoriesUsecase.call();
    result.fold(
      (l) => emit(CategoryError(message: l.message)),
      (r) => emit(CategoryLoaded(categories: r)),
    );
  }

  void _getProductCategoryList(
      GetProductCategoryListRequest event,
      Emitter<CategoryState> emit,
      ) async {
    emit(CategoryLoading());
    final result = await productCategoryListUsecase.call();

    result.fold(
          (l) => emit(CategoryError(message: l.message)),
          (r) => emit(ProductCategoryListLoaded(productCategories:  r)),
    );
  }
}
