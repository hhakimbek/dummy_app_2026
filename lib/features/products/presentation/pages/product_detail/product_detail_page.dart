import 'package:dummy_app_2026/core/theme/app_theme.dart';
import 'package:dummy_app_2026/features/products/presentation/bloc/product_list/product_bloc.dart' hide ProductBloc, ProductState;
import 'package:dummy_app_2026/features/products/presentation/pages/widgets/info_tile.dart';
import 'package:dummy_app_2026/features/products/presentation/pages/widgets/pill_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product_detail/product_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final int id;
  const ProductDetailPage({super.key, required this.id});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _currentImage = 0;

  @override
  void initState() {
    super.initState();
    _onGetProduct();
  }

  void _onGetProduct() {
    context.read<ProductBloc>().add(GetSingleProductRequest(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final productTheme = theme.extension<ProductThemeExtension>();

    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            final product = state.product;
            final discountedPrice = product.price * (1 - product.discountPercentage / 100);

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 320,
                  leading: const BackButton(),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        PageView.builder(
                          itemCount: product.images.isEmpty ? 1 : product.images.length,
                          onPageChanged: (index) => setState(() => _currentImage = index),
                          itemBuilder: (context, index) {
                            final imageUrl = product.images.isEmpty
                                ? product.thumbnail
                                : product.images[index];

                            return Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: colorScheme.surfaceContainerHighest,
                                alignment: Alignment.center,
                                child: const Icon(Icons.broken_image, size: 40),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          left: 12,
                          right: 12,
                          bottom: 12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              product.images.isEmpty ? 1 : product.images.length,
                                  (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                width: _currentImage == index ? 18 : 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: _currentImage == index
                                      ? colorScheme.onPrimary
                                      : colorScheme.onPrimary.withValues(alpha: 0.54),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            PillWidget(text: product.category, icon: Icons.category_outlined),
                            const SizedBox(width: 8),
                            PillWidget(
                              text: product.brand,
                              icon: Icons.branding_watermark_outlined,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${discountedPrice.toStringAsFixed(2)}",
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: productTheme?.priceColor ?? colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "\$${product.price.toStringAsFixed(2)}",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "-${product.discountPercentage.toStringAsFixed(0)}%",
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: productTheme?.discountColor ?? colorScheme.error,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        Row(
                          children: [
                            Icon(Icons.star, color: colorScheme.tertiary, size: 20),
                            const SizedBox(width: 4),
                            Text(product.rating.toStringAsFixed(1)),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.inventory_2_outlined,
                              color: colorScheme.onSurfaceVariant,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text("Stock: ${product.stock}"),
                          ],
                        ),
                        const SizedBox(height: 18),

                        Text(
                          "Description",
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 18),

                        if (product.tags.isNotEmpty) ...[
                          Text(
                            "Tags",
                            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: product.tags
                                .map(
                                  (e) => Chip(
                                label: Text(e),
                                visualDensity: VisualDensity.compact,
                              ),
                            )
                                .toList(),
                          ),
                          const SizedBox(height: 18),
                        ],

                        InfoTile(icon: Icons.qr_code_2, title: "SKU", value: product.sku),
                        InfoTile(icon: Icons.scale_outlined, title: "Weight", value: "${product.weight} g"),
                        InfoTile(
                          icon: Icons.local_shipping_outlined,
                          title: "Shipping",
                          value: product.shippingInformation,
                        ),
                        InfoTile(
                          icon: Icons.verified_user_outlined,
                          title: "Warranty",
                          value: product.warrantyInformation,
                        ),
                        InfoTile(
                          icon: Icons.cached_outlined,
                          title: "Return policy",
                          value: product.returnPolicy,
                        ),
                        InfoTile(
                          icon: Icons.info_outline,
                          title: "Availability",
                          value: product.availabilityStatus,
                        ),
                        InfoTile(
                          icon: Icons.shopping_bag_outlined,
                          title: "Min order qty",
                          value: "${product.minimumOrderQuantity}",
                        ),
                        InfoTile(
                          icon: Icons.rate_review_outlined,
                          title: "Reviews count",
                          value: "${product.reviews.length}",
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
