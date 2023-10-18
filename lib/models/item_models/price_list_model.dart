class PriceListModel {
  final int? priceListID;
  final String? priceListName;

  const PriceListModel({
    this.priceListID,
    this.priceListName,
  });

  static PriceListModel fromJson(Map<String, dynamic> json) => PriceListModel(
        priceListID: json['price_list_id'] as int?,
        priceListName: json['price_list_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'price_list_id': priceListID,
        'price_list_name': priceListName,
      };

  PriceListModel copy({
    int? priceListID,
    String? priceListName,
  }) =>
      PriceListModel(
        priceListID: priceListID ?? this.priceListID,
        priceListName: priceListName ?? this.priceListName,
      );
}
