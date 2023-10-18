class ItemUnitModel {
  final int? itemID;
  final int? unitID;
  final int? conversionFactor;

  const ItemUnitModel({
    this.itemID,
    this.unitID,
    this.conversionFactor,
  });

  static ItemUnitModel fromJson(Map<String, dynamic> json) => ItemUnitModel(
        itemID: json['item_id'] as int?,
        unitID: json['unit_id'] as int?,
        conversionFactor: json['conversion_factor'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'item_id': itemID,
        'unit_id': unitID,
        'conversion_factor': conversionFactor,
      };

  ItemUnitModel copy({
    int? itemID,
    int? unitID,
    int? conversionFactor,
  }) =>
      ItemUnitModel(
        itemID: itemID ?? this.itemID,
        unitID: unitID ?? this.unitID,
        conversionFactor: conversionFactor ?? this.conversionFactor,
      );
}
