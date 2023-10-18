class VendorModel {
  final int? vendorID;
  final String? vendorName;
  final String? vendorAddress;
  final String? vendorPhone;
  final String? vendorNotes;
  final String? vendorTaxCode;
  final String? vendorRegNo;

  const VendorModel({
    this.vendorID,
    this.vendorName,
    this.vendorAddress,
    this.vendorPhone,
    this.vendorNotes,
    this.vendorTaxCode,
    this.vendorRegNo,
  });

  static VendorModel fromJson(Map<String, dynamic> json) => VendorModel(
        vendorID: json['vendor_id'] as int?,
        vendorName: json['vendor_name'] as String?,
        vendorAddress: json['vendor_address'] as String?,
        vendorPhone: json['vendor_phone'] as String?,
        vendorNotes: json['vendor_notes'] as String?,
        vendorTaxCode: json['vendor_tax_code'] as String?,
        vendorRegNo: json['vendor_reg_no'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'vendor_id': vendorID,
        'vendor_name': vendorName,
        'vendor_address': vendorAddress,
        'vendor_phone': vendorPhone,
        'vendor_notes': vendorNotes,
        'vendor_reg_no': vendorRegNo,
        'vendor_tax_code': vendorTaxCode,
      };

  VendorModel copy({
    int? vendorID,
    String? vendorName,
    String? vendorAddress,
    String? vendorPhone,
    String? vendorNotes,
    String? vendorRegNo,
    String? vendorTaxCode,
  }) =>
      VendorModel(
        vendorID: vendorID ?? this.vendorID,
        vendorName: vendorName ?? this.vendorName,
        vendorAddress: vendorAddress ?? this.vendorAddress,
        vendorPhone: vendorPhone ?? this.vendorPhone,
        vendorNotes: vendorNotes ?? this.vendorNotes,
        vendorRegNo: vendorRegNo ?? this.vendorRegNo,
        vendorTaxCode: vendorTaxCode ?? this.vendorTaxCode,
      );
}
