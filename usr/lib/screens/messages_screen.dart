import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final conversations = [
      {
        'name': 'Emma',
        'lastMessage': 'Hey! How are you?',
        'time': '2m ago',
        'unread': 2,
        'avatar': 'https://picsum.photos/400/600?random=1',
      },
      {
        'name': 'Olivia',
        'lastMessage': 'That sounds great! 😊',
        'time': '1h ago',
        'unread': 0,
        'avatar': 'https://picsum.photos/400/600?random=3',
      },
      {
        'name': 'Isabella',
        'lastMessage': 'Coffee tomorrow?',
        'time': '3h ago',
        'unread': 1,
        'avatar': 'https://picsum.photos/400/600?random=5',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: conversations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message_outlined,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No messages yet',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Start matching to chat!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(conversation['avatar'] as String),
                      ),
                      if ((conversation['unread'] as int) > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 20,
                              minHeight: 20,
                            ),
                            child: Text(
                              '${conversation['unread']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(
                    conversation['name'] as String,
                    style: TextStyle(
                      fontWeight: (conversation['unread'] as int) > 0
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    conversation['lastMessage'] as String,
                    style: TextStyle(
                      color: (conversation['unread'] as int) > 0
                          ? Colors.black87
                          : Colors.grey,
                      fontWeight: (conversation['unread'] as int) > 0
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    conversation['time'] as String,
                    style: TextStyle(
                      color: (conversation['unread'] as int) > 0
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  onTap: () {
                    // Navigate to chat detail
                  },
                );
              },
            ),
    );
  }
}