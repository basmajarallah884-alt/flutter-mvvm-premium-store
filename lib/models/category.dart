class Category {
  final String slug;
  final String name;
  final String url;
  final String? image;

  Category({
    required this.slug,
    required this.name,
    required this.url,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      slug: json['slug'],
      name: json['name'],
      url: json['url'],
      image: _getCategoryImage(json['slug']),
    );
  }

  static String? _getCategoryImage(String slug) {
    final String k = slug.toLowerCase().trim();
    
    // Standard high-reliability Unsplash URLs (No "Plus" links to avoid restrictions)

    if (k.contains('beauty')) return 'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?q=80&w=500&h=400&fit=crop';
    if (k.contains('fragrance')) return 'https://images.unsplash.com/photo-1541643600914-78b084683601?q=80&w=600&h=400&fit=crop';
    if (k.contains('furniture')) return 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?q=80&w=600&h=400&fit=crop';
    if (k.contains('grocery') || k.contains('groceries')) return 'https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=600&h=400&fit=crop';
    if (k.contains('home-decoration')) return 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?q=80&w=600&h=400&fit=crop';
    if (k.contains('kitchen')) return 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?q=80&w=600&h=400&fit=crop';
    if (k.contains('laptop')) return 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?q=80&w=600&h=400&fit=crop';
    if (k.contains('shirt')) return 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?q=80&w=600&h=400&fit=crop';
    if (k.contains('shoe')) return 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=600&h=400&fit=crop';
    if (k.contains('watch')) return 'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?q=80&w=600&h=400&fit=crop';
    if (k.contains('mobile') || k.contains('accessory')) return 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=600&h=400&fit=crop';
    if (k.contains('motorcycle')) return 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=600&h=400&fit=crop';
    if (k.contains('skin-care')) return 'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?q=80&w=600&h=400&fit=crop';
    if (k.contains('smartphone')) return 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=600&h=400&fit=crop';
    if (k.contains('sport')) return 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=600&h=400&fit=crop';
    if (k.contains('sunglass')) return 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?q=80&w=600&h=400&fit=crop';
    if (k.contains('tablet')) return 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?q=80&w=600&h=400&fit=crop';
    if (k.contains('top')) return 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?q=80&w=600&h=400&fit=crop';
    if (k.contains('vehicle') || k.contains('car')) return 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?q=80&w=600&h=400&fit=crop';
    if (k.contains('bag') || k.contains('bage')) return 'https://images.unsplash.com/photo-1591561954557-26941169b49e?q=80&w=500&h=400&fit=crop';
    if (k.contains('dress')) return 'https://images.unsplash.com/photo-1496747611176-843222e1e57c?q=80&w=600&h=400&fit=crop';
    if (k.contains('jewellery') || k.contains('jewelry')) return 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?q=80&w=600&h=400&fit=crop';

    // Generic fallback for any other category
    return 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=500&h=400&fit=crop';
  }
}
