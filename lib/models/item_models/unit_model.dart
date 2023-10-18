class UnitModel {
  final int? unitID;
  final String? unitName;

  const UnitModel({
    this.unitID,
    this.unitName,
  });

  static UnitModel fromJson(Map<String, dynamic> json) => UnitModel(
        unitID: json['unit_id'] as int?,
        unitName: json['unit_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'unit_id': unitID,
        'unit_name': unitName,
      };

  UnitModel copy({
    int? unitID,
    String? unitName,
  }) =>
      UnitModel(
        unitID: unitID ?? this.unitID,
        unitName: unitName ?? this.unitName,
      );
}
