class ItemModel {
  final int? itemID;
  final String? itemName;
  final String? itemDesc;
  final double? itemMinQuantity;
  final double? itemStock;
  final int? itemCategory;

  const ItemModel({
    this.itemID,
    this.itemName,
    this.itemDesc,
    this.itemMinQuantity,
    this.itemStock,
    this.itemCategory,
  });

  static ItemModel fromJson(Map<String, dynamic> json) => ItemModel(
        itemID: json['item_id'] as int?,
        itemName: json['item_name'] as String?,
        itemDesc: json['item_desc'] as String?,
        itemMinQuantity: json['item_min_quantity'] as double?,
        itemStock: json['item_stock'] as double?,
        itemCategory: json['item_category'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'item_id': itemID,
        'item_name': itemName,
        'item_desc': itemDesc,
        'item_min_quantity': itemMinQuantity,
        'item_stock': itemStock,
        'item_category': itemCategory,
      };

  ItemModel copy({
    int? itemID,
    String? itemName,
    String? itemDesc,
    double? itemMinQuantity,
    double? itemStock,
    int? itemCategory,
  }) =>
      ItemModel(
        itemID: itemID ?? this.itemID,
        itemName: itemName ?? this.itemName,
        itemDesc: itemDesc ?? this.itemDesc,
        itemMinQuantity: itemMinQuantity ?? this.itemMinQuantity,
        itemStock: itemStock ?? this.itemStock,
        itemCategory: itemCategory ?? this.itemCategory,
      );
}
