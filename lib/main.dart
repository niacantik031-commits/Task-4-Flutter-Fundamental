import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ProductsPage(),
    );
  }
}

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk kategori (Sudah diperbaiki ikon & warnanya)
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.checkroom, 'label': 'Tshirt'},
      {'icon': Icons.hiking, 'label': 'Shoes', 'isSelected': true}, // Menggunakan ikon resmi yang tersedia
      {'icon': Icons.local_mall, 'label': 'Bag'}, 
      {'icon': Icons.dry_cleaning, 'label': 'Dress'},
      {'icon': Icons.watch, 'label': 'Watch'},
    ];

    // Data dummy untuk produk
    final List<Map<String, dynamic>> products = [
      {
        'title': 'Mint Leather Sneakers',
        'image': 'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=500&q=80',
        'bgColor': const Color(0xE3D1F9EC),
        'price': 212.5,
        'oldPrice': 250.0,
        'discount': 15,
      },
      {
        'title': 'Classic White Sneakers',
        'image': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=500&q=80',
        'bgColor': const Color(0xFFFCE4EC),
        'price': 180.0,
        'oldPrice': 200.0,
        'discount': 10,
      },
      {
        'title': 'Dark Wash Denim Jacket',
        'image': 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=500&q=80',
        'bgColor': const Color(0xFFF5F5F5),
        'price': 212.5,
        'oldPrice': 250.0,
        'discount': 15,
      },
      {
        'title': 'Urban Sport Watch',
        'image': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&q=80',
        'bgColor': const Color(0xFFEFEFEF),
        'price': 180.0,
        'oldPrice': 200.0,
        'discount': 10,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Products',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search men fashion...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Kategori Horizontal List
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isSelected = cat['isSelected'] ?? false;
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              // Memakai .withValues() sebagai pengganti .withOpacity() yang deprecated
                              color: isSelected ? const Color(0xFFFFEBEE) : const Color(0xFFFFCDD2).withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(16),
                              border: isSelected ? Border.all(color: Colors.redAccent, width: 1.5) : null,
                            ),
                            child: Icon(
                              cat['icon'], 
                              color: isSelected ? Colors.redAccent : Colors.red[900],
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            cat['label'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: Colors.black87,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),

              // Filter & Total Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Mengatur children diletakkan paling terakhir agar linter senang
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '967 Products',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Based on your filter',
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildIconButton(Icons.list, false),
                      const SizedBox(width: 8),
                      _buildIconButton(Icons.grid_view, true),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Grid Produk
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: product['bgColor'],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              product['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image, size: 50, color: Colors.grey);
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '\$${product['price']}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '\$${product['oldPrice']}',
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${product['discount']}%',
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          // Memakai .withValues() sebagai pengganti .withOpacity() yang deprecated
          color: isSelected ? Colors.redAccent : Colors.grey.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.redAccent : Colors.grey,
        size: 20,
      ),
    );
  }
}