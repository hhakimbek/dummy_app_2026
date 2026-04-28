import 'package:dummy_app_2026/core/router/app_router.dart';
import 'package:dummy_app_2026/features/products/presentation/bloc/product_list/product_bloc.dart';
import 'package:dummy_app_2026/features/products/presentation/pages/product_list/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  final TextEditingController _searchController = TextEditingController();

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
    context.read<ProductsBloc>().add(GetProductsRequest());
  }

  void _onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      context.read<ProductsBloc>().add(const GetProductsRequest());
    } else {
      context.read<ProductsBloc>().add(
        SearchProductsRequested(query.trim()),
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
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () =>
                context.read<ProductsBloc>().add(const GetProductsRequest()),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
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
      body: BlocListener<ProductsBloc, ProductsState>(
        listener: (context, state) {
          print(state);
        },
        child: BlocBuilder<ProductsBloc, ProductsState>(
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
      ),
    );
  }
}
