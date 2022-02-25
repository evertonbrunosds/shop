class CartItem {
  final String id;
  final String productId;
  final String name;
  final int quantity;
  final double price;

  const CartItem({
    required final this.id,
    required final this.productId,
    required final this.name,
    required final this.quantity,
    required final this.price,
  });
}
