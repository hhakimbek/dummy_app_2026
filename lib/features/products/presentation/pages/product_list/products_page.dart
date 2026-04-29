import 'package:dummy_app_2026/core/router/app_router.dart';
import 'package:dummy_app_2026/features/products/presentation/bloc/product_list/product_bloc.dart';
import 'package:dummy_app_2026/features/products/presentation/pages/product_list/widgets/product_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  final TextEditingController _searchController = TextEditingController();
  String? _activeSortBy;
  String? _activeOrder;


  @override
  void initState() {
    _onGetProducts();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onGetProducts() async {
    print("_activeOrder: $_activeOrder, _activeSortBy: $_activeSortBy");
    context.read<ProductsBloc>().add(GetProductsRequest(sortBy: _activeSortBy,order: _activeOrder));
  }

  void _onSearchChanged(String query) {
    print("_activeOrder: $_activeOrder, _activeSortBy: $_activeSortBy");
    if (query.trim().isEmpty) {
      context.read<ProductsBloc>().add(GetProductsRequest(sortBy: _activeSortBy,order: _activeOrder));
    } else {
      context.read<ProductsBloc>().add(
        SearchProductsRequested(query: query.trim(),sortBy: _activeSortBy,order: _activeOrder),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        scrolledUnderElevation: 0,
        actions: [
          PopupMenuButton<SortType>(
            icon: const Icon(Icons.sort),
            onSelected: (SortType value) {
              switch (value) {
                case SortType.az:
                  _activeOrder = "asc";
                  _activeSortBy = "title";
                  break;
                case SortType.za:
                  _activeOrder = "desc";
                  _activeSortBy = "title";
                  break;
                case SortType.priceHighToLow:
                  _activeOrder = "desc";
                  _activeSortBy = "price";
                  break;
                case SortType.priceLowToHigh:
                  _activeOrder = "asc";
                  _activeSortBy = "price";
                  break;
                case SortType.ratingHighToLow:
                  _activeOrder = "desc";
                  _activeSortBy = "rating";
                  break;
                case SortType.ratingLowToHigh:
                  _activeOrder = "asc";
                  _activeSortBy = "rating";
                  break;
                case SortType.def:
                  _activeSortBy=null;
                  _activeOrder=null;
                  break;
              }
              final query = _searchController.text.trim();
              context.read<ProductsBloc>().add(
                query.isEmpty
                    ? GetProductsRequest(sortBy: _activeSortBy, order: _activeOrder)
                    : SearchProductsRequested(query: query, sortBy: _activeSortBy, order: _activeOrder),
              );

            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: SortType.def,
                child: Text("Default"),
              ),
              const PopupMenuItem(
                value: SortType.az,
                child: Text("Alphabet: A → Z"),
              ),
              const PopupMenuItem(
                value: SortType.za,
                child: Text("Alphabet: Z → A"),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: SortType.priceHighToLow,
                child: Text("Price: High → Low"),
              ),
              const PopupMenuItem(
                value: SortType.priceLowToHigh,
                child: Text("Price: Low → High"),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: SortType.ratingHighToLow,
                child: Text("Rating: High → Low"),
              ),
              const PopupMenuItem(
                value: SortType.ratingLowToHigh,
                child: Text("Rating: Low → High"),
              ),
            ],
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => _onSearchChanged(value,),
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: ListenableBuilder(
                  listenable: _searchController,
                  builder: (context, _) => _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear_rounded),
                    onPressed: () {
                      _searchController.clear();
                      _onGetProducts();
                    },
                  )
                      : const SizedBox.shrink(),
                ),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoaded) {
            final products = state.products; // List<Product>

            if (products.isEmpty) {
              return const Center(child: Text("Mahsulotlar topilmadi"));
            }

            return RefreshIndicator(
              onRefresh: () async {
                _onGetProducts();
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final product = products[index];
                  final discountedPrice = product.price * (1 - product.discountPercentage / 100);

                  return ProductCard(product: product, discountedPrice: discountedPrice);
                },
              ),
            );
          }
          else if (state is ProductsError) {
            return Center(child: Text(state.message));
          } else if(state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
enum SortType {
  az,
  za,
  priceHighToLow,
  priceLowToHigh,
  ratingHighToLow,
  ratingLowToHigh,
  def
}