import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Profile header
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage('https://picsum.photos/400/600?random=20'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        radius: 20,
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'You',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // Edit profile
                  },
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
          const Divider(),
          // Profile sections
          _buildSection(
            context,
            icon: Icons.person,
            title: 'Edit Profile',
            onTap: () {},
          ),
          _buildSection(
            context,
            icon: Icons.photo_library,
            title: 'Photos',
            onTap: () {},
          ),
          _buildSection(
            context,
            icon: Icons.favorite,
            title: 'Dating Preferences',
            onTap: () {},
          ),
          _buildSection(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {},
          ),
          const Divider(),
          _buildSection(
            context,
            icon: Icons.workspace_premium,
            title: 'Get Premium',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Upgrade',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {},
          ),
          const Divider(),
          _buildSection(
            context,
            icon: Icons.shield,
            title: 'Safety & Privacy',
            onTap: () {},
          ),
          _buildSection(
            context,
            icon: Icons.help,
            title: 'Help & Support',
            onTap: () {},
          ),
          _buildSection(
            context,
            icon: Icons.info,
            title: 'About',
            onTap: () {},
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: OutlinedButton(
              onPressed: () {
                // Logout
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.red),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing ??
          Icon(
            Icons.chevron_right,
            color: Colors.grey[400],
          ),
      onTap: onTap,
    );
  }
}