import 'package:flutter/material.dart';
import '../widgets/swipe_card.dart';
import '../models/user_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<UserProfile> _profiles = [
    UserProfile(
      id: '1',
      name: 'Emma',
      age: 25,
      bio: 'Love traveling and photography 📸',
      distance: 5,
      photos: ['https://picsum.photos/400/600?random=1'],
      interests: ['Travel', 'Photography', 'Coffee'],
    ),
    UserProfile(
      id: '2',
      name: 'Sophia',
      age: 28,
      bio: 'Fitness enthusiast & foodie 🏋️‍♀️🍕',
      distance: 8,
      photos: ['https://picsum.photos/400/600?random=2'],
      interests: ['Fitness', 'Cooking', 'Yoga'],
    ),
    UserProfile(
      id: '3',
      name: 'Olivia',
      age: 26,
      bio: 'Artist | Music lover | Dog mom 🎨🎵🐕',
      distance: 3,
      photos: ['https://picsum.photos/400/600?random=3'],
      interests: ['Art', 'Music', 'Dogs'],
    ),
    UserProfile(
      id: '4',
      name: 'Ava',
      age: 27,
      bio: 'Adventure seeker and book lover 📚⛰️',
      distance: 12,
      photos: ['https://picsum.photos/400/600?random=4'],
      interests: ['Reading', 'Hiking', 'Adventure'],
    ),
    UserProfile(
      id: '5',
      name: 'Isabella',
      age: 24,
      bio: 'Coffee addict ☕ | Netflix binger',
      distance: 6,
      photos: ['https://picsum.photos/400/600?random=5'],
      interests: ['Coffee', 'Movies', 'Cooking'],
    ),
  ];

  void _handleSwipe(String direction, UserProfile profile) {
    setState(() {
      if (_currentIndex < _profiles.length - 1) {
        _currentIndex++;
      } else {
        // All profiles swiped
        _showNoMoreProfilesDialog();
      }
    });

    if (direction == 'right') {
      _showMatchDialog(profile);
    }
  }

  void _showMatchDialog(UserProfile profile) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('It\'s a Match! 💕'),
        content: Text('You and ${profile.name} liked each other!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keep Swiping'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to messages
            },
            child: const Text('Send Message'),
          ),
        ],
      ),
    );
  }

  void _showNoMoreProfilesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('No More Profiles'),
        content: const Text('Check back later for more people nearby!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_fire_department,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text(
              'Discover',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              // Open filters
            },
          ),
        ],
      ),
      body: _currentIndex < _profiles.length
          ? Center(
              child: SwipeCard(
                profile: _profiles[_currentIndex],
                onSwipe: _handleSwipe,
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No more profiles',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Check back later!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}