import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'lobby_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B5E20),
              Color(0xFF2E7D32),
              Color(0xFF1B5E20),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo区域
                const Icon(
                  Icons.casino,
                  size: 120,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  '德州扑克',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const Text(
                  'TEXAS HOLD\'EM',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 80),
                
                // 菜单按钮
                _MenuButton(
                  icon: Icons.play_circle_filled,
                  label: '快速开始',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _MenuButton(
                  icon: Icons.group,
                  label: '游戏大厅',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LobbyScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _MenuButton(
                  icon: Icons.person,
                  label: '个人中心',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _MenuButton(
                  icon: Icons.help_outline,
                  label: '游戏规则',
                  onTap: () {
                    _showRulesDialog(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRulesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('德州扑克规则'),
        content: const SingleChildScrollView(
          child: Text(
            '基本规则：\n\n'
            '1. 每位玩家发两张底牌\n'
            '2. 桌面依次发出5张公共牌\n'
            '3. 玩家用自己的2张底牌和5张公共牌组成最佳的5张牌\n'
            '4. 牌型大小：皇家同花顺 > 同花顺 > 四条 > 葫芦 > 同花 > 顺子 > 三条 > 两对 > 一对 > 高牌\n\n'
            '游戏流程：\n'
            '• 翻牌前（Pre-flop）: 发底牌后第一轮下注\n'
            '• 翻牌（Flop）: 发3张公共牌\n'
            '• 转牌（Turn）: 发第4张公共牌\n'
            '• 河牌（River）: 发第5张公共牌\n'
            '• 摊牌（Showdown）: 比较牌型大小',
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 280,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}