import 'package:flutter/material.dart';

const Color _kAccentColor = Color(0xFF7A2EF0);
const Color _kBackground = Color(0xFFF7F8FB);
const Color _kSurface = Colors.white;
const Color _kBodyText = Color(0xFF4F5565);
const Color _kCaption = Color(0xFF8C92A1);

const List<Map<String, dynamic>> _filterChips = [
  {'label': 'Location', 'selected': true},
  {'label': 'Budget', 'selected': false},
  {'label': 'Gender', 'selected': false},
  {'label': 'Room type', 'selected': false},
  {'label': 'University', 'selected': false},
];

const List<Map<String, String>> _featuredListings = [
  {
    'image': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800&q=80',
    'price': r'$420 / mo',
    'title': 'Bright private room — 650ft to campus',
    'location': 'East Heights, London',
    'distance': '0.8 mi',
    'roommates': '2 roommates',
  },
  {
    'image': 'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=800&q=80',
    'price': r'$550 / mo',
    'title': 'Modern ensuite with city access',
    'location': 'Green Quarter, London',
    'distance': '1.2 mi',
    'roommates': '1 roommate',
  },
];

const List<Map<String, String>> _recentListings = [
  {
    'image': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=900&q=80',
    'title': 'Bright Room in Shared Flat',
    'price': r'$380/mo',
    'snippet': 'Sunny room with built-in wardrobe and high-speed Wi-Fi. Available from June.',
    'location': 'Camden Town',
    'distance': '2.1 MI',
    'roommates': '3 RM',
    'address': '142 Olympic Way, Wembley HA9 0NP',
    'verified': 'true',
  },
  {
    'image': 'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=900&q=80',
    'title': 'Penthouse Room w/ City View',
    'price': r'$720/mo',
    'snippet': 'Experience luxury living in the heart of the financial district. Access to gym and pool.',
    'location': 'Isle of Dogs',
    'distance': '0.8 MI',
    'roommates': '2 RM',
    'address': '22 Marsh Wall, E14 9AF',
    'verified': 'true',
  },
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildGreeting(),
                  const SizedBox(height: 20),
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                  _buildFilterChips(),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Featured listings', 'See all'),
                  const SizedBox(height: 16),
                  _buildFeaturedList(),
                  const SizedBox(height: 26),
                  _buildSectionHeader('Recent listings', 'Filtered by: University', showBadge: true),
                  const SizedBox(height: 16),
                  ..._recentListings.map(_buildRecentCard),
                  const SizedBox(height: 24),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: _kAccentColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.bolt, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Room-Match',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87)),
              ],
            ),
          ],
        ),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200, width: 1.5),
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=200&q=80'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Good morning, Alex',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.4)),
        SizedBox(height: 8),
        Text('6 new rooms near Central University',
            style: TextStyle(fontSize: 15, color: _kBodyText, height: 1.5)),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, 6),
            blurRadius: 18,
          ),
        ],
      ),
      child: TextField(
        style: const TextStyle(fontSize: 15, color: Colors.black87),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          hintText: 'Search by location, uni, or keyword',
          hintStyle: const TextStyle(color: Color(0xFF9EA6BB)),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 16, right: 10),
            child: Icon(Icons.search, color: Color(0xFF9EA6BB), size: 22),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 50),
          suffixIcon: const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.filter_list, color: _kAccentColor, size: 22),
          ),
          suffixIconConstraints: const BoxConstraints(minWidth: 50),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filterChips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final chip = _filterChips[index];
          final selected = chip['selected'] as bool;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? _kAccentColor : _kSurface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: selected ? _kAccentColor : const Color(0xFFE7E9F0)),
            ),
            child: Row(
              children: [
                Text(chip['label'] as String,
                    style: TextStyle(
                      color: selected ? Colors.white : _kBodyText,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 13,
                    )),
                const SizedBox(width: 8),
                Icon(Icons.keyboard_arrow_down,
                    size: 18, color: selected ? Colors.white : const Color(0xFF9EA6BB)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action, {bool showBadge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87)),
            if (showBadge) ...[
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F3FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('NEW', style: TextStyle(color: _kAccentColor, fontSize: 12, fontWeight: FontWeight.w700)),
              ),
            ]
          ],
        ),
        Text(action,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _kAccentColor)),
      ],
    );
  }

  Widget _buildFeaturedList() {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _featuredListings.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final item = _featuredListings[index];
          return Container(
            width: 240,
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            item['image']!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(color: const Color(0xFFECEFF4)),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.verified, color: _kAccentColor, size: 14),
                                SizedBox(width: 6),
                                Text('VERIFIED', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _kAccentColor)),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black.withOpacity(0.45), Colors.transparent],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['price']!,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                                const SizedBox(height: 4),
                                Text(item['location']!,
                                    style: const TextStyle(fontSize: 13, color: Colors.white70)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.place, size: 14, color: _kCaption),
                          const SizedBox(width: 6),
                          Text(item['distance']!, style: const TextStyle(fontSize: 12, color: _kCaption)),
                          const SizedBox(width: 10),
                          const Icon(Icons.group, size: 14, color: _kCaption),
                          const SizedBox(width: 6),
                          Text(item['roommates']!, style: const TextStyle(fontSize: 12, color: _kCaption)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentCard(Map<String, String> listing) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: Image.network(
                  listing['image']!,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: const Color(0xFFECEFF4),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.favorite_border, color: _kAccentColor, size: 20),
                ),
              ),
              if (listing['verified'] == 'true')
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.verified, color: _kAccentColor, size: 14),
                        SizedBox(width: 6),
                        Text('Verified', style: TextStyle(fontSize: 11, color: _kAccentColor, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(listing['title']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black87)),
                const SizedBox(height: 6),
                Text(listing['price']!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _kAccentColor)),
                const SizedBox(height: 10),
                Text(listing['snippet']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: _kBodyText, height: 1.5)),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.place, size: 14, color: _kCaption),
                    const SizedBox(width: 6),
                    Text(listing['location']!, style: const TextStyle(fontSize: 12, color: _kCaption)),
                    const SizedBox(width: 14),
                    const Icon(Icons.location_on_outlined, size: 14, color: _kCaption),
                    const SizedBox(width: 6),
                    Text(listing['distance']!, style: const TextStyle(fontSize: 12, color: _kCaption)),
                    const SizedBox(width: 14),
                    const Icon(Icons.group_outlined, size: 14, color: _kCaption),
                    const SizedBox(width: 6),
                    Text(listing['roommates']!, style: const TextStyle(fontSize: 12, color: _kCaption)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(listing['address']!,
                    style: const TextStyle(fontSize: 13, color: _kCaption, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: bottomPadding > 0 ? bottomPadding : 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 18, offset: Offset(0, -6)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(icon: Icons.home_filled, label: 'Home', active: true),
          _buildNavItem(icon: Icons.search, label: 'Search'),
          _buildNavItem(icon: Icons.add_circle_outline, label: 'Add Listing'),
          _buildNavItem(icon: Icons.chat_bubble_outline, label: 'Chats'),
          _buildNavItem(icon: Icons.person_outline, label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, bool active = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: active ? _kAccentColor : const Color(0xFF9EA6BB)),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: active ? _kAccentColor : const Color(0xFF9EA6BB),
            )),
      ],
    );
  }
}
