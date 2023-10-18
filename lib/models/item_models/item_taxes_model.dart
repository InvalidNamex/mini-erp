class ItemTaxesModel {
  final int? itemID;
  final int? taxID;
  final int? taxPercentage;

  const ItemTaxesModel({
    this.itemID,
    this.taxID,
    this.taxPercentage = 0,
  });

  static ItemTaxesModel fromJson(Map<String, dynamic> json) => ItemTaxesModel(
        itemID: json['item_id'] as int?,
        taxID: json['tax_id'] as int?,
        taxPercentage: json['tax_percentage'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'item_id': itemID,
        'tax_id': taxID,
        'tax_percentage': taxPercentage,
      };

  ItemTaxesModel copy({
    int? itemID,
    int? taxID,
    int? taxPercentage,
  }) =>
      ItemTaxesModel(
        itemID: itemID ?? this.itemID,
        taxID: taxID ?? this.taxID,
        taxPercentage: taxPercentage ?? this.taxPercentage,
      );
}
