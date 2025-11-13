enum CardSuit {
  hearts,   // 红桃
  diamonds, // 方块
  clubs,    // 梅花
  spades,   // 黑桃
}

enum CardRank {
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king,
  ace,
}

class PlayingCard {
  final CardSuit suit;
  final CardRank rank;

  PlayingCard({
    required this.suit,
    required this.rank,
  });

  String get suitSymbol {
    switch (suit) {
      case CardSuit.hearts:
        return '♥';
      case CardSuit.diamonds:
        return '♦';
      case CardSuit.clubs:
        return '♣';
      case CardSuit.spades:
        return '♠';
    }
  }

  String get rankSymbol {
    switch (rank) {
      case CardRank.two:
        return '2';
      case CardRank.three:
        return '3';
      case CardRank.four:
        return '4';
      case CardRank.five:
        return '5';
      case CardRank.six:
        return '6';
      case CardRank.seven:
        return '7';
      case CardRank.eight:
        return '8';
      case CardRank.nine:
        return '9';
      case CardRank.ten:
        return '10';
      case CardRank.jack:
        return 'J';
      case CardRank.queen:
        return 'Q';
      case CardRank.king:
        return 'K';
      case CardRank.ace:
        return 'A';
    }
  }

  bool get isRed => suit == CardSuit.hearts || suit == CardSuit.diamonds;

  @override
  String toString() => '$rankSymbol$suitSymbol';
}