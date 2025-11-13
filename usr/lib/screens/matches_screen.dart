import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<UserProfile> matches = [
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
        id: '3',
        name: 'Olivia',
        age: 26,
        bio: 'Artist | Music lover | Dog mom 🎨🎵🐕',
        distance: 3,
        photos: ['https://picsum.photos/400/600?random=3'],
        interests: ['Art', 'Music', 'Dogs'],
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Matches',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: matches.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No matches yet',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Start swiping to find matches!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      // Navigate to chat
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(match.photos.first),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${match.name}, ${match.age}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${match.distance} km away',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  match.bio,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.message,
                                  color:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {
                                  // Navigate to chat
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}