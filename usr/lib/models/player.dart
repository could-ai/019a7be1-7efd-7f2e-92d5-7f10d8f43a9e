import 'card.dart';

class Player {
  final String id;
  final String name;
  int chips;
  List<PlayingCard> holeCards;
  int currentBet;
  bool hasFolded;
  bool isHuman;
  String? position; // 'dealer', 'small_blind', 'big_blind'

  Player({
    required this.id,
    required this.name,
    required this.chips,
    this.holeCards = const [],
    this.currentBet = 0,
    this.hasFolded = false,
    this.isHuman = false,
    this.position,
  });

  void bet(int amount) {
    if (amount > chips) {
      amount = chips; // All-in
    }
    chips -= amount;
    currentBet += amount;
  }

  void fold() {
    hasFolded = true;
  }

  void reset() {
    holeCards = [];
    currentBet = 0;
    hasFolded = false;
  }

  void winPot(int amount) {
    chips += amount;
  }

  bool get isAllIn => chips == 0 && currentBet > 0;

  @override
  String toString() => '$name (¥$chips)';
}