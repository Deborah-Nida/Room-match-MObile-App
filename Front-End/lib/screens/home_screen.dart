import 'package:flutter/material.dart';
import 'add_property_screen.dart';

const Color _kAccentColor = Color(0xFF7A2EF0);
const Color _kBackground = Color(0xFFF7F8FB);
const Color _kSurface = Colors.white;
const Color _kBodyText = Color(0xFF111827);
const Color _kCaption = Color(0xFF6B7280);
const Color _kBorder = Color(0xFFE5E7EB);

const List<String> _filterChips = ['Location', 'Budget', 'Room type'];

const List<Map<String, dynamic>> _featuredListings = [
  {
    'image':
        'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800&q=80',
    'price': r'$420 / mo',
    'title': 'Cozy Studio near Central Uni',
    'location': 'East Heights, London',
    'details': '2 roommates',
    'tags': ['Location', 'Budget'],
  },
  {
    'image':
        'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=800&q=80',
    'price': r'$550 / mo',
    'title': 'Modern ensuite with city access',
    'location': 'Green Quarter, London',
    'details': '1 roommate',
    'tags': ['Room type'],
  },
];

const List<Map<String, dynamic>> _recentListings = [
  {
    'image':
        'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=900&q=80',
    'title': 'Bright Room in Shared Flat',
    'price': r'$380/mo',
    'snippet':
        'Sunny room with built-in wardrobe and high-speed Wi-Fi. Available from June.',
    'location': 'Camden Town',
    'distance': '2.1 miles',
    'roommates': '3 RM',
    'address': '142 Olympic Way, Wembley HA9 0NP',
    'tags': ['Location', 'Room type'],
  },
  {
    'image':
        'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=900&q=80',
    'title': 'Penthouse Room w/ City View',
    'price': r'$720/mo',
    'snippet':
        'Experience luxury living in the heart of the city. Access to gym and pool.',
    'location': 'Isle of Dogs',
    'distance': '0.8 miles',
    'roommates': '2 RM',
    'address': '22 Marsh Wall, E14 9AF',
    'tags': ['Budget', 'Room type'],
  },
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<String> _activeFilters = {};

  List<Map<String, dynamic>> _filteredListings(
    List<Map<String, dynamic>> items,
  ) {
    if (_activeFilters.isEmpty) return items;
    return items.where((item) {
      final tags = item['tags'] as List<String>;
      return tags.any(_activeFilters.contains);
    }).toList();
  }

  void _toggleFilter(String label) {
    setState(() {
      if (_activeFilters.contains(label)) {
        _activeFilters.remove(label);
      } else {
        _activeFilters.add(label);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final featuredListings = _filteredListings(_featuredListings);
    final recentListings = _filteredListings(_recentListings);

    return Scaffold(
      backgroundColor: _kBackground,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          backgroundColor: _kBackground,
          elevation: 0,
          toolbarHeight: 90,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: _kAccentColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Icon(Icons.bolt, color: Colors.white, size: 24),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Room-Match',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _kBodyText,
                    ),
                  ),
                ),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: NetworkImage('https://i.pravatar.cc/100'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              const Text(
                'Good morning, Alex',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: _kBodyText,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: const [
                  Icon(Icons.location_on_outlined, size: 16, color: _kCaption),
                  SizedBox(width: 6),
                  Text(
                    '6 new rooms near Central University',
                    style: TextStyle(fontSize: 14, color: _kCaption),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              _buildSearchBar(),
              const SizedBox(height: 18),
              _buildFilterChips(),
              const SizedBox(height: 24),
              _buildSectionHeader('Featured listings', 'See all'),
              const SizedBox(height: 18),
              _buildFeaturedList(featuredListings),
              const SizedBox(height: 26),
              _buildSectionHeader(
                'Recent listings',
                _activeFilters.isEmpty
                    ? 'Filtered by: all'
                    : 'Filtered by: ${_activeFilters.join(', ')}',
                showBadge: false,
              ),
              const SizedBox(height: 18),
              ...recentListings.map(_buildRecentCard),
              const SizedBox(height: 20),
              _buildNoMatchesCard(),
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _kAccentColor,
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddPropertyScreen()));
        },
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.search, color: _kCaption),
          const SizedBox(width: 12),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search by location, uni, or keyword',
                hintStyle: TextStyle(color: _kCaption),
              ),
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _kAccentColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.tune, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filterChips.map((label) {
          final bool selected = _activeFilters.contains(label);
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(label),
              selected: selected,
              onSelected: (_) => _toggleFilter(label),
              selectedColor: _kAccentColor,
              backgroundColor: _kSurface,
              labelStyle: TextStyle(
                color: selected ? Colors.white : _kBodyText,
                fontWeight: FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    String action, {
    bool showBadge = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _kBodyText,
          ),
        ),
        Row(
          children: [
            if (showBadge)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _kSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kBorder),
                ),
                child: const Text(
                  'University',
                  style: TextStyle(
                    fontSize: 12,
                    color: _kAccentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (showBadge) const SizedBox(width: 10),
            Text(
              action,
              style: const TextStyle(
                fontSize: 14,
                color: _kAccentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturedList(List<Map<String, dynamic>> listings) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        double cardWidth = screenWidth * 0.78;
        if (cardWidth < 280) cardWidth = 280;
        if (cardWidth > 340) cardWidth = 340;

        return SizedBox(
          height: cardWidth * 1.05,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: listings.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return SizedBox(
                width: cardWidth,
                child: _buildFeaturedCard(listings[index], cardWidth),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFeaturedCard(Map<String, dynamic> item, double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
                child: SizedBox(
                  width: width,
                  height: width * 0.58,
                  child: Image.network(
                    item['image']!,
                    width: width,
                    height: width * 0.58,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 14,
                right: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.9),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.check_circle, color: _kAccentColor, size: 14),
                      SizedBox(width: 6),
                      Text(
                        'VERIFIED',
                        style: TextStyle(
                          fontSize: 10,
                          color: _kBodyText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['price']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kAccentColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['title']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kBodyText,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: _kCaption,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        item['location']!,
                        style: const TextStyle(fontSize: 12, color: _kCaption),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item['details']!,
                  style: const TextStyle(fontSize: 12, color: _kCaption),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            child: Image.network(
              item['image']!,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item['title']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: _kBodyText,
                        ),
                      ),
                    ),
                    const Icon(Icons.favorite_border, color: _kAccentColor),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item['price']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kAccentColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['snippet']!,
                  style: const TextStyle(fontSize: 14, color: _kCaption),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 14,
                  runSpacing: 8,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _buildTagRow(
                      icon: Icons.location_on_outlined,
                      text: item['location']!,
                    ),
                    _buildTagRow(
                      icon: Icons.circle,
                      text: item['distance']!,
                      iconSize: 8,
                    ),
                    _buildTagText(item['roommates']!),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  item['address']!,
                  style: const TextStyle(fontSize: 12, color: _kCaption),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE9FE),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text(
                    'AVAILABLE NOW',
                    style: TextStyle(
                      fontSize: 12,
                      color: _kAccentColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagRow({
    required IconData icon,
    required String text,
    double iconSize = 14,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: _kCaption),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 12, color: _kCaption)),
      ],
    );
  }

  Widget _buildTagText(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _kBorder),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12, color: _kCaption)),
    );
  }

  Widget _buildNoMatchesCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'No matches found?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _kBodyText,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Try widening your search area or adjusting your budget filters to see more listings.',
            style: TextStyle(fontSize: 14, color: _kCaption, height: 1.5),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _kAccentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {},
              child: const Text(
                'Reset filters',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      color: _kSurface,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.home, color: _kAccentColor),
            Icon(Icons.search, color: _kCaption),
            SizedBox(width: 48),
            Icon(Icons.chat_bubble_outline, color: _kCaption),
            Icon(Icons.person_outline, color: _kCaption),
          ],
        ),
      ),
    );
  }
}
