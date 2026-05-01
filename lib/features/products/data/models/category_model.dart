import 'package:dummy_app_2026/features/products/domain/entities/category.dart';

class CategoryModel extends Category{
  CategoryModel({required super.slug, required super.name, required super.url});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    slug: json["slug"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "name": name,
    "url": url,
  };
}