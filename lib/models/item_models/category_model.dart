class CategoryModel {
  final int? categoryID;
  final String? categoryName;

  const CategoryModel({
    this.categoryID,
    this.categoryName,
  });
  static CategoryModel fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryID: json['category_id'] as int?,
        categoryName: json['category_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'category_id': categoryID,
        'category_name': categoryName,
      };

  // to store the generated id
  CategoryModel copy({
    int? categoryID,
    String? categoryName,
  }) =>
      CategoryModel(
        categoryID: categoryID ?? this.categoryID,
        categoryName: categoryName ?? this.categoryName,
      );
}
