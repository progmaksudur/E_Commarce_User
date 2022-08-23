const String cartProductId = "productId";
const String cartProductName = "productName";
const String cartProductImage = "productImage";
const String cartProductPrice = "productPrice";
const String cartProductQuantity = "productQuantity";

class CartModel {
  String? productId;
  String? productName;
  String? imageUrl;
  num salePrice;
  num quantity;

  CartModel({
    this.productId,
    this.productName,
    this.imageUrl,
    required this.salePrice,
    this.quantity=1,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      cartProductId: productId,
      cartProductName: productName,
      cartProductImage: imageUrl,
      cartProductPrice: salePrice,
      cartProductQuantity: quantity,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) => CartModel(
    productId: map[cartProductId],
    productName: map[cartProductName],
    imageUrl: map[cartProductImage],
    salePrice: map[cartProductPrice],
    quantity: map[cartProductQuantity],
  );
}
