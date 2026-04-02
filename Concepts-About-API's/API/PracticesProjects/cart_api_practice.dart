import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ══════════════════════════════════════════
//  MODELS
// ══════════════════════════════════════════

class CartProductModel {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final double discountPercentage;
  final double discountedTotal;
  final String thumbnail;

  CartProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      total: (json['total'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      discountedTotal: (json['discountedTotal'] ?? 0).toDouble(),
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}

class CartModel {
  final int id;
  final int userId;
  final double total;
  final double discountedTotal;
  final int totalProducts;
  final int totalQuantity;
  final List<CartProductModel> products;

  CartModel({
    required this.id,
    required this.userId,
    required this.total,
    required this.discountedTotal,
    required this.totalProducts,
    required this.totalQuantity,
    required this.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      total: (json['total'] ?? 0).toDouble(),
      discountedTotal: (json['discountedTotal'] ?? 0).toDouble(),
      totalProducts: json['totalProducts'] ?? 0,
      totalQuantity: json['totalQuantity'] ?? 0,
      products: (json['products'] as List? ?? [])
          .map((item) => CartProductModel.fromJson(item))
          .toList(),
    );
  }

  // Kitni savings hui total mein
  double get totalSavings => total - discountedTotal;
}

// ══════════════════════════════════════════
//  API SERVICE
// ══════════════════════════════════════════

class CartService {
  static const String _url = 'https://dummyjson.com/carts?limit=30';

  static Future<List<CartModel>> fetchCarts() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List cartsJson = data['carts'];
      return cartsJson.map((item) => CartModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load carts. Status: ${response.statusCode}');
    }
  }
}

// ══════════════════════════════════════════
//  MAIN
// ══════════════════════════════════════════

void main() => runApp(const CartApp());

class CartApp extends StatelessWidget {
  const CartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cart Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F0EB),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFE8521A),
          secondary: Color(0xFF1A1A1A),
        ),
        useMaterial3: true,
      ),
      home: const CartListScreen(),
    );
  }
}

// ══════════════════════════════════════════
//  CART LIST SCREEN
// ══════════════════════════════════════════

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  late Future<List<CartModel>> _cartsFuture;

  @override
  void initState() {
    super.initState();
    _cartsFuture = CartService.fetchCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0EB),
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cart Manager',
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              'dummyjson.com/carts',
              style: TextStyle(
                color: Color(0xFFE8521A),
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Color(0xFF1A1A1A)),
            onPressed: () => setState(() {
              _cartsFuture = CartService.fetchCarts();
            }),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FutureBuilder<List<CartModel>>(
        future: _cartsFuture,
        builder: (context, snapshot) {

          // ── Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Color(0xFFE8521A),
                    strokeWidth: 2.5,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading carts...',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          // ── Error
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8521A).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.cloud_off_rounded,
                        size: 36,
                        color: Color(0xFFE8521A),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Connection Failed',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      style: const TextStyle(
                        color: Color(0xFF888888),
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => setState(() {
                        _cartsFuture = CartService.fetchCarts();
                      }),
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Try Again'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE8521A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // ── Empty
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No carts found.',
                style: TextStyle(color: Color(0xFF888888)),
              ),
            );
          }

          // ── Success
          final carts = snapshot.data!;
          return Column(
            children: [
              // Summary header
              _SummaryHeader(carts: carts),

              // Cart list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: carts.length,
                  itemBuilder: (context, index) {
                    return CartCard(cart: carts[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ══════════════════════════════════════════
//  SUMMARY HEADER
// ══════════════════════════════════════════

class _SummaryHeader extends StatelessWidget {
  final List<CartModel> carts;
  const _SummaryHeader({required this.carts});

  @override
  Widget build(BuildContext context) {
    final totalCarts = carts.length;
    final totalValue = carts.fold(0.0, (sum, c) => sum + c.discountedTotal);
    final totalItems = carts.fold(0, (sum, c) => sum + c.totalQuantity);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(label: 'Carts', value: '$totalCarts'),
          _Divider(),
          _StatItem(label: 'Items', value: '$totalItems'),
          _Divider(),
          _StatItem(
            label: 'Total Value',
            value: '\$${(totalValue / 1000).toStringAsFixed(1)}k',
            accent: true,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final bool accent;
  const _StatItem(
      {required this.label, required this.value, this.accent = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: accent ? const Color(0xFFE8521A) : Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF888888),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30,
      color: Colors.white.withOpacity(0.1),
    );
  }
}

// ══════════════════════════════════════════
//  CART CARD WIDGET
// ══════════════════════════════════════════

class CartCard extends StatelessWidget {
  final CartModel cart;
  const CartCard({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CartDetailScreen(cart: cart),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            // ── Top row
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
              child: Row(
                children: [
                  // Cart ID badge
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8521A).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '#${cart.id}',
                        style: const TextStyle(
                          color: Color(0xFFE8521A),
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Cart info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cart #${cart.id}  •  User ${cart.userId}',
                          style: const TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${cart.totalProducts} products  •  ${cart.totalQuantity} items',
                          style: const TextStyle(
                            color: Color(0xFF888888),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Arrow
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFCCCCCC),
                    size: 22,
                  ),
                ],
              ),
            ),

            // ── Product thumbnails strip
            SizedBox(
              height: 56,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: cart.products.length,
                itemBuilder: (context, index) {
                  final product = cart.products[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 8, bottom: 4),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F0EB),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color(0xFFE8E8E8), width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image_not_supported,
                          size: 20,
                          color: Color(0xFFCCCCCC),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ── Bottom price row
            Container(
              margin: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F0EB),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Original price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Original',
                        style: TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        '\$${cart.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 13,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  // Savings
                  Column(
                    children: [
                      const Text(
                        'You Save',
                        style:
                            TextStyle(color: Color(0xFF888888), fontSize: 11),
                      ),
                      Text(
                        '\$${cart.totalSavings.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  // Discounted total
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Total',
                        style:
                            TextStyle(color: Color(0xFF888888), fontSize: 11),
                      ),
                      Text(
                        '\$${cart.discountedTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Color(0xFFE8521A),
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
//  CART DETAIL SCREEN
// ══════════════════════════════════════════

class CartDetailScreen extends StatelessWidget {
  final CartModel cart;
  const CartDetailScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0EB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Color(0xFF1A1A1A), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Cart #${cart.id}',
          style: const TextStyle(
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE8521A).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'User #${cart.userId}',
              style: const TextStyle(
                color: Color(0xFFE8521A),
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Cart Summary Card
            _CartSummaryCard(cart: cart),
            const SizedBox(height: 20),

            // ── Products heading
            Row(
              children: [
                const Text(
                  'Products',
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${cart.totalProducts}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Product list
            ...cart.products
                .map((product) => CartProductCard(product: product)),
          ],
        ),
      ),

      // ── Bottom bar
      bottomNavigationBar: _BottomCheckout(cart: cart),
    );
  }
}

// ── Cart Summary Card
class _CartSummaryCard extends StatelessWidget {
  final CartModel cart;
  const _CartSummaryCard({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InfoTile(
                icon: Icons.shopping_bag_outlined,
                label: 'Products',
                value: '${cart.totalProducts}',
              ),
              _InfoTile(
                icon: Icons.layers_outlined,
                label: 'Total Qty',
                value: '${cart.totalQuantity}',
              ),
              _InfoTile(
                icon: Icons.local_offer_outlined,
                label: 'Savings',
                value: '\$${cart.totalSavings.toStringAsFixed(0)}',
                accent: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF2E2E2E)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Original Price',
                style:
                    TextStyle(color: Color(0xFF888888), fontSize: 13),
              ),
              Text(
                '\$${cart.total.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Color(0xFF888888),
                  fontSize: 13,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Discounted Total',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '\$${cart.discountedTotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Color(0xFFE8521A),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool accent;
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.accent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon,
            color: accent ? const Color(0xFFE8521A) : const Color(0xFF888888),
            size: 20),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: accent ? const Color(0xFFE8521A) : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style:
              const TextStyle(color: Color(0xFF888888), fontSize: 11),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════
//  CART PRODUCT CARD
// ══════════════════════════════════════════

class CartProductCard extends StatelessWidget {
  final CartProductModel product;
  const CartProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final savings = product.total - product.discountedTotal;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.thumbnail,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 70,
                height: 70,
                color: const Color(0xFFF5F0EB),
                child: const Icon(Icons.image_not_supported,
                    color: Color(0xFFCCCCCC)),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Price + Qty
                Row(
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFF888888),
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8521A).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '-${product.discountPercentage.toStringAsFixed(1)}%',
                        style: const TextStyle(
                          color: Color(0xFFE8521A),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quantity badge
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F0EB),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Qty: ${product.quantity}',
                            style: const TextStyle(
                              color: Color(0xFF1A1A1A),
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Save \$${savings.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    // Total
                    Text(
                      '\$${product.discountedTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFFE8521A),
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════
//  BOTTOM CHECKOUT BAR
// ══════════════════════════════════════════

class _BottomCheckout extends StatelessWidget {
  final CartModel cart;
  const _BottomCheckout({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Total info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Checkout Total',
                  style: TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 12,
                  ),
                ),
                Text(
                  '\$${cart.discountedTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),

          // Checkout button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE8521A),
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Checkout',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
