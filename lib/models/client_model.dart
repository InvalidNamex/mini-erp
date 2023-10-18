class ClientModel {
  final int? clientID;
  final int? clientPriceList;
  final double? clientMaxLimit;
  final String? clientName;
  final String? clientAddress;
  final String? clientPhone;
  final String? clientNotes;
  final String? clientTaxCode;
  final String? clientRegNo;

  const ClientModel({
    this.clientID,
    this.clientPriceList,
    this.clientName,
    this.clientAddress,
    this.clientPhone,
    this.clientNotes,
    this.clientTaxCode,
    this.clientRegNo,
    this.clientMaxLimit,
  });
  static ClientModel fromJson(Map<String, dynamic> json) => ClientModel(
        clientID: json['client_id'] as int?,
        clientPriceList: json['client_price_list'] as int?,
        clientMaxLimit: json['client_max_limit'] as double?,
        clientName: json['client_name'] as String?,
        clientAddress: json['client_address'] as String?,
        clientPhone: json['client_phone'] as String?,
        clientNotes: json['client_notes'] as String?,
        clientTaxCode: json['client_tax_code'] as String?,
        clientRegNo: json['client_reg_no'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'client_id': clientID,
        'client_price_list': clientPriceList,
        'client_max_limit': clientMaxLimit,
        'client_name': clientName,
        'client_address': clientAddress,
        'client_phone': clientPhone,
        'client_notes': clientNotes,
        'client_tax_code': clientTaxCode,
        'client_reg_no': clientRegNo
      };

  // to store the generated id
  ClientModel copy({
    int? clientID,
    int? clientPriceList,
    double? clientMaxLimit,
    String? clientName,
    String? clientAddress,
    String? clientPhone,
    String? clientNotes,
    String? clientRegNo,
    String? clientTaxCode,
  }) =>
      ClientModel(
        clientID: clientID ?? this.clientID,
        clientPriceList: clientPriceList ?? this.clientPriceList,
        clientMaxLimit: clientMaxLimit ?? this.clientMaxLimit,
        clientName: clientName ?? this.clientName,
        clientAddress: clientAddress ?? this.clientAddress,
        clientPhone: clientPhone ?? this.clientPhone,
        clientNotes: clientNotes ?? this.clientNotes,
        clientRegNo: clientRegNo ?? this.clientRegNo,
        clientTaxCode: clientTaxCode ?? this.clientTaxCode,
      );
}
