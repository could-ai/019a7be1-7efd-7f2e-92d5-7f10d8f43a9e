import 'package:flutter/material.dart';
import '../models/card.dart';
import '../models/player.dart';
import '../widgets/playing_card_widget.dart';
import '../widgets/player_seat_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<PlayingCard> communityCards = [];
  List<Player> players = [];
  int currentPot = 0;
  int currentBet = 0;
  String gamePhase = 'Pre-flop';
  Player? currentPlayer;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    // 初始化6个玩家
    players = [
      Player(id: '1', name: '你', chips: 10000, isHuman: true),
      Player(id: '2', name: '玩家2', chips: 8500, isHuman: false),
      Player(id: '3', name: '玩家3', chips: 12000, isHuman: false),
      Player(id: '4', name: '玩家4', chips: 9000, isHuman: false),
      Player(id: '5', name: '玩家5', chips: 11500, isHuman: false),
      Player(id: '6', name: '玩家6', chips: 7800, isHuman: false),
    ];

    // 给每个玩家发两张底牌（示例）
    players[0].holeCards = [
      PlayingCard(suit: CardSuit.hearts, rank: CardRank.ace),
      PlayingCard(suit: CardSuit.spades, rank: CardRank.king),
    ];

    currentPlayer = players[0];
    currentPot = 150;
    currentBet = 50;
  }

  void _dealFlop() {
    setState(() {
      communityCards = [
        PlayingCard(suit: CardSuit.hearts, rank: CardRank.ten),
        PlayingCard(suit: CardSuit.diamonds, rank: CardRank.jack),
        PlayingCard(suit: CardSuit.hearts, rank: CardRank.queen),
      ];
      gamePhase = 'Flop';
    });
  }

  void _dealTurn() {
    setState(() {
      communityCards.add(
        PlayingCard(suit: CardSuit.clubs, rank: CardRank.nine),
      );
      gamePhase = 'Turn';
    });
  }

  void _dealRiver() {
    setState(() {
      communityCards.add(
        PlayingCard(suit: CardSuit.hearts, rank: CardRank.eight),
      );
      gamePhase = 'River';
    });
  }

  void _performAction(String action) {
    setState(() {
      if (action == 'fold') {
        players[0].hasFolded = true;
      } else if (action == 'call') {
        players[0].currentBet = currentBet;
        players[0].chips -= currentBet;
        currentPot += currentBet;
      } else if (action == 'raise') {
        int raiseAmount = currentBet * 2;
        players[0].currentBet = raiseAmount;
        players[0].chips -= raiseAmount;
        currentPot += raiseAmount;
        currentBet = raiseAmount;
      }
    });

    // 演示：自动发牌
    Future.delayed(const Duration(milliseconds: 500), () {
      if (communityCards.isEmpty) {
        _dealFlop();
      } else if (communityCards.length == 3) {
        _dealTurn();
      } else if (communityCards.length == 4) {
        _dealRiver();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              Color(0xFF2E7D32),
              Color(0xFF1B5E20),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 顶部信息栏
              _buildTopBar(),
              
              Expanded(
                child: Stack(
                  children: [
                    // 牌桌
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B5E20),
                          borderRadius: BorderRadius.circular(200),
                          border: Border.all(
                            color: const Color(0xFF8D6E63),
                            width: 12,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // 公共牌
                              _buildCommunityCards(),
                              const SizedBox(height: 20),
                              // 底池
                              _buildPotInfo(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // 玩家座位
                    _buildPlayerSeats(),
                  ],
                ),
              ),
              
              // 底部操作区
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              gamePhase,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityCards() {
    if (communityCards.isEmpty) {
      return const Text(
        '等待发牌...',
        style: TextStyle(color: Colors.white70, fontSize: 16),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: communityCards
          .map((card) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: PlayingCardWidget(card: card, size: 60),
              ))
          .toList(),
    );
  }

  Widget _buildPotInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.amber, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.monetization_on, color: Colors.amber, size: 24),
          const SizedBox(width: 8),
          Text(
            '底池: ¥$currentPot',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerSeats() {
    // 玩家位置布局（围绕牌桌）
    return Stack(
      children: [
        // 玩家1（自己）- 底部中心
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: PlayerSeatWidget(
              player: players[0],
              isActive: currentPlayer?.id == players[0].id,
              showCards: true,
            ),
          ),
        ),
        // 玩家2 - 左下
        Positioned(
          bottom: 100,
          left: 20,
          child: PlayerSeatWidget(
            player: players[1],
            isActive: currentPlayer?.id == players[1].id,
          ),
        ),
        // 玩家3 - 左上
        Positioned(
          top: 100,
          left: 20,
          child: PlayerSeatWidget(
            player: players[2],
            isActive: currentPlayer?.id == players[2].id,
          ),
        ),
        // 玩家4 - 顶部中心
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Center(
            child: PlayerSeatWidget(
              player: players[3],
              isActive: currentPlayer?.id == players[3].id,
            ),
          ),
        ),
        // 玩家5 - 右上
        Positioned(
          top: 100,
          right: 20,
          child: PlayerSeatWidget(
            player: players[4],
            isActive: currentPlayer?.id == players[4].id,
          ),
        ),
        // 玩家6 - 右下
        Positioned(
          bottom: 100,
          right: 20,
          child: PlayerSeatWidget(
            player: players[5],
            isActive: currentPlayer?.id == players[5].id,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    if (players[0].hasFolded) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: const Text(
          '已弃牌，等待下一局...',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ActionButton(
            label: '弃牌',
            color: Colors.red,
            onPressed: () => _performAction('fold'),
          ),
          _ActionButton(
            label: '跟注 ¥$currentBet',
            color: Colors.blue,
            onPressed: () => _performAction('call'),
          ),
          _ActionButton(
            label: '加注',
            color: Colors.green,
            onPressed: () => _performAction('raise'),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}