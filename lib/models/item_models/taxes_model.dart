class TaxesModel {
  final int? taxID;
  final String? taxName;

  const TaxesModel({
    this.taxID,
    this.taxName,
  });

  static TaxesModel fromJson(Map<String, dynamic> json) => TaxesModel(
        taxID: json['tax_id'] as int?,
        taxName: json['tax_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'tax_id': taxID,
        'tax_name': taxName,
      };

  TaxesModel copy({
    int? taxID,
    String? taxName,
  }) =>
      TaxesModel(
        taxID: taxID ?? this.taxID,
        taxName: taxName ?? this.taxName,
      );
}
