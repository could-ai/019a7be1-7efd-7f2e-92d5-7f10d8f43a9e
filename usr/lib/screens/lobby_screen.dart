import 'package:flutter/material.dart';
import 'game_screen.dart';

class LobbyScreen extends StatelessWidget {
  const LobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('游戏大厅'),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B5E20),
              Color(0xFF2E7D32),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _RoomCard(
              roomName: '新手房间',
              blinds: '小盲: ¥10 / 大盲: ¥20',
              players: '4/6',
              minBuyin: 1000,
              onJoin: () => _joinRoom(context, '新手房间'),
            ),
            _RoomCard(
              roomName: '进阶房间',
              blinds: '小盲: ¥50 / 大盲: ¥100',
              players: '3/6',
              minBuyin: 5000,
              onJoin: () => _joinRoom(context, '进阶房间'),
            ),
            _RoomCard(
              roomName: '高级房间',
              blinds: '小盲: ¥100 / 大盲: ¥200',
              players: '5/6',
              minBuyin: 10000,
              onJoin: () => _joinRoom(context, '高级房间'),
            ),
            _RoomCard(
              roomName: 'VIP房间',
              blinds: '小盲: ¥500 / 大盲: ¥1000',
              players: '2/6',
              minBuyin: 50000,
              isVip: true,
              onJoin: () => _joinRoom(context, 'VIP房间'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _createRoom(context),
              icon: const Icon(Icons.add),
              label: const Text('创建私人房间'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _joinRoom(BuildContext context, String roomName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GameScreen(),
      ),
    );
  }

  void _createRoom(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('创建私人房间'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: '房间名称',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: '房间密码（可选）',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _joinRoom(context, '私人房间');
            },
            child: const Text('创建'),
          ),
        ],
      ),
    );
  }
}

class _RoomCard extends StatelessWidget {
  final String roomName;
  final String blinds;
  final String players;
  final int minBuyin;
  final bool isVip;
  final VoidCallback onJoin;

  const _RoomCard({
    required this.roomName,
    required this.blinds,
    required this.players,
    required this.minBuyin,
    this.isVip = false,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isVip ? Colors.amber : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onJoin,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (isVip)
                    const Icon(Icons.star, color: Colors.amber, size: 24),
                  if (isVip) const SizedBox(width: 8),
                  Text(
                    roomName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isVip ? Colors.amber : null,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      players,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.visibility, size: 18, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    blinds,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.account_balance_wallet,
                      size: 18, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '最小买入: ¥$minBuyin',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}