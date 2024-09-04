class Product {
  final String? productId;
  final String? category;
  final String? brand;
  final String? name;
  final String? color;
  final String? hexColor;
  final String? memory;
  final double? price;
  final int? stock;
  final String? image;
  final String? specifications;
  final int? wattage;
  final int? sales;
  late int? quantityInCart;

  Product({
    this.productId,
    required this.category,
    required this.brand,
    required this.name,
    required this.color,
    required this.memory,
    required this.price,
    required this.stock,
    required this.image,
    required this.specifications,
    required this.wattage,
    required this.sales,
    required this.hexColor,
    this.quantityInCart,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'productId': productId,
      'category': category,
      'brand': brand,
      'name': name,
      'color': color,
      'hexColor': hexColor,
      'memory': memory,
      'price': price,
      'stock': stock,
      'image': image,
      'specifications': specifications,
      'wattage': wattage,
      'sales': sales,
      'quantityInCart': quantityInCart,
    };
    return json;
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      category: json['category'],
      brand: json['brand'],
      name: json['name'],
      color: json['color'],
      hexColor: json['hexColor'],
      memory: json['memory'],
      price: json['price'],
      stock: json['stock'],
      image: json['image'],
      specifications: json['specifications'],
      wattage: json['wattage'],
      sales: json['sales'],
      quantityInCart: json['quantityInCart'],
    );
  }
}
