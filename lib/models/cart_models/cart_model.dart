class CartModel {
  final int? cartID;
  final DateTime? dateTimestamp;

  const CartModel({
    this.cartID,
    this.dateTimestamp,
  });

  static CartModel fromJson(Map<String, dynamic> json) => CartModel(
        cartID: json['cart_id'] as int?,
        dateTimestamp: DateTime.parse(json['date_timestamp'] as String? ?? ''),
      );

  Map<String, dynamic> toJson() => {
        'cart_id': cartID,
        'date_timestamp': dateTimestamp?.toIso8601String(),
      };

  CartModel copy({
    int? cartID,
    DateTime? dateTimestamp,
  }) =>
      CartModel(
        cartID: cartID ?? this.cartID,
        dateTimestamp: dateTimestamp ?? this.dateTimestamp,
      );
}
