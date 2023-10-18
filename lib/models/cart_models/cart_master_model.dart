class CartMasterModel {
  final int? cartMasterID;
  final int? cartID;
  final int? cartItemID;
  final double? total;
  final double? discount;
  final double? paid;
  final double? remaining;
  final String? clientName;
  final String? note;
  final int? payType;

  const CartMasterModel({
    this.cartMasterID,
    this.cartID,
    this.cartItemID,
    this.total,
    this.discount,
    this.paid,
    this.remaining,
    this.clientName,
    this.note,
    this.payType,
  });

  static CartMasterModel fromJson(Map<String, dynamic> json) => CartMasterModel(
        cartMasterID: json['cart_master_id'] as int?,
        cartID: json['cart_id'] as int?,
        cartItemID: json['cart_item_id'] as int?,
        total: json['total'] as double?,
        discount: json['discount'] as double?,
        paid: json['paid'] as double?,
        remaining: json['remaining'] as double?,
        clientName: json['client_name'] as String?,
        note: json['note'] as String?,
        payType: json['pay_type'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'cart_master_id': cartMasterID,
        'cart_id': cartID,
        'cart_item_id': cartItemID,
        'total': total,
        'discount': discount,
        'paid': paid,
        'remaining': remaining,
        'client_name': clientName,
        'note': note,
        'pay_type': payType,
      };

  CartMasterModel copy({
    int? cartMasterID,
    int? cartID,
    int? cartItemID,
    double? total,
    double? discount,
    double? paid,
    double? remaining,
    String? clientName,
    String? note,
    int? payType,
  }) =>
      CartMasterModel(
        cartMasterID: cartMasterID ?? this.cartMasterID,
        cartID: cartID ?? this.cartID,
        cartItemID: cartItemID ?? this.cartItemID,
        total: total ?? this.total,
        discount: discount ?? this.discount,
        paid: paid ?? this.paid,
        remaining: remaining ?? this.remaining,
        clientName: clientName ?? this.clientName,
        note: note ?? this.note,
        payType: payType ?? this.payType,
      );
}
