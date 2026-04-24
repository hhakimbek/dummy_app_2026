import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _primaryColor = Color(0xFF6C63FF);
  static const Color _secondaryColor = Color(0xFF03DAC6);
  static const Color _successColor = Color(0xFF1B8F3A);
  static const Color _dangerColor = Color(0xFFD64343);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      secondary: _secondaryColor,
      brightness: Brightness.light,
    ),
    extensions: const [
      ProductThemeExtension(
        priceColor: _successColor,
        discountColor: _dangerColor,
      ),
    ],
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(color: Colors.grey.shade900),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      secondary: _secondaryColor,
      brightness: Brightness.dark,
    ),
    extensions: const [
      ProductThemeExtension(
        priceColor: Color(0xFF5DCA7A),
        discountColor: Color(0xFFFF8A8A),
      ),
    ],
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.white12,
      labelStyle: const TextStyle(color: Colors.white),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
  );
}

@immutable
class ProductThemeExtension extends ThemeExtension<ProductThemeExtension> {
  final Color priceColor;
  final Color discountColor;

  const ProductThemeExtension({
    required this.priceColor,
    required this.discountColor,
  });

  @override
  ProductThemeExtension copyWith({
    Color? priceColor,
    Color? discountColor,
  }) {
    return ProductThemeExtension(
      priceColor: priceColor ?? this.priceColor,
      discountColor: discountColor ?? this.discountColor,
    );
  }

  @override
  ProductThemeExtension lerp(
    covariant ThemeExtension<ProductThemeExtension>? other,
    double t,
  ) {
    if (other is! ProductThemeExtension) {
      return this;
    }

    return ProductThemeExtension(
      priceColor: Color.lerp(priceColor, other.priceColor, t) ?? priceColor,
      discountColor: Color.lerp(discountColor, other.discountColor, t) ?? discountColor,
    );
  }
}
