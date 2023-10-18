class CartItemModel {
  final int? cartItemID;
  final String? cartItemName;
  final double? cartItemPrice;
  final double? cartItemQuantity;
  final double? cartItemTotal;

  const CartItemModel({
    this.cartItemID,
    this.cartItemName,
    this.cartItemPrice,
    this.cartItemQuantity,
    this.cartItemTotal,
  });

  static CartItemModel fromJson(Map<String, dynamic> json) => CartItemModel(
        cartItemID: json['cart_item_id'] as int?,
        cartItemName: json['cart_item_name'] as String?,
        cartItemPrice: json['cart_item_price'] as double?,
        cartItemQuantity: json['cart_item_quantity'] as double?,
        cartItemTotal: json['cart_item_total'] as double?,
      );

  Map<String, dynamic> toJson() => {
        'cart_item_id': cartItemID,
        'cart_item_name': cartItemName,
        'cart_item_price': cartItemPrice,
        'cart_item_quantity': cartItemQuantity,
        'cart_item_total': cartItemTotal,
      };

  CartItemModel copy({
    int? cartItemID,
    String? cartItemName,
    double? cartItemPrice,
    double? cartItemQuantity,
    double? cartItemTotal,
  }) =>
      CartItemModel(
        cartItemID: cartItemID ?? this.cartItemID,
        cartItemName: cartItemName ?? this.cartItemName,
        cartItemPrice: cartItemPrice ?? this.cartItemPrice,
        cartItemQuantity: cartItemQuantity ?? this.cartItemQuantity,
        cartItemTotal: cartItemTotal ?? this.cartItemTotal,
      );
}
