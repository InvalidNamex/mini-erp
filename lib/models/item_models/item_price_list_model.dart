class ItemPriceListModel {
  final int? itemID;
  final int? priceListID;
  final double? price;

  const ItemPriceListModel({
    this.itemID,
    this.priceListID,
    this.price,
  });

  static ItemPriceListModel fromJson(Map<String, dynamic> json) =>
      ItemPriceListModel(
        itemID: json['item_id'] as int?,
        priceListID: json['price_list_id'] as int?,
        price: json['price'] as double?,
      );

  Map<String, dynamic> toJson() => {
        'item_id': itemID,
        'price_list_id': priceListID,
        'price': price,
      };

  ItemPriceListModel copy({
    int? itemID,
    int? priceListID,
    double? price,
  }) =>
      ItemPriceListModel(
        itemID: itemID ?? this.itemID,
        priceListID: priceListID ?? this.priceListID,
        price: price ?? this.price,
      );
}
