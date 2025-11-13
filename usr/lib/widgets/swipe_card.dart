import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class SwipeCard extends StatefulWidget {
  final UserProfile profile;
  final Function(String direction, UserProfile profile) onSwipe;

  const SwipeCard({
    super.key,
    required this.profile,
    required this.onSwipe,
  });

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  Offset _dragOffset = Offset.zero;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });

    final screenWidth = MediaQuery.of(context).size.width;

    if (_dragOffset.dx.abs() > screenWidth * 0.3) {
      // Swipe threshold reached
      final direction = _dragOffset.dx > 0 ? 'right' : 'left';
      _animateCardOff(direction);
    } else {
      // Return to center
      _resetPosition();
    }
  }

  void _animateCardOff(String direction) {
    final screenWidth = MediaQuery.of(context).size.width;
    final endX = direction == 'right' ? screenWidth * 2 : -screenWidth * 2;

    _animation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset(endX, _dragOffset.dy),
    ).animate(_controller);

    _controller.forward().then((_) {
      widget.onSwipe(direction, widget.profile);
      _controller.reset();
      setState(() {
        _dragOffset = Offset.zero;
      });
    });
  }

  void _resetPosition() {
    _animation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset.zero,
    ).animate(_controller);

    _controller.forward().then((_) {
      _controller.reset();
      setState(() {
        _dragOffset = Offset.zero;
      });
    });
  }

  void _handleLike() {
    _dragOffset = Offset(MediaQuery.of(context).size.width * 0.5, 0);
    _animateCardOff('right');
  }

  void _handleDislike() {
    _dragOffset = Offset(-MediaQuery.of(context).size.width * 0.5, 0);
    _animateCardOff('left');
  }

  @override
  Widget build(BuildContext context) {
    final rotation = _dragOffset.dx / 1000;
    final opacity = 1 - (_dragOffset.dx.abs() / 500).clamp(0.0, 1.0);

    Offset currentOffset = _dragOffset;
    if (_controller.isAnimating) {
      currentOffset = _animation.value;
    }

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Transform.translate(
              offset: currentOffset,
              child: Transform.rotate(
                angle: rotation,
                child: GestureDetector(
                  onPanStart: _onPanStart,
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Profile image
                          Image.network(
                            widget.profile.photos.first,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                          // Gradient overlay
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.8),
                                ],
                                stops: const [0.5, 1.0],
                              ),
                            ),
                          ),
                          // Profile info
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.profile.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '${widget.profile.age}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${widget.profile.distance} km away',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    widget.profile.bio,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: widget.profile.interests
                                        .map(
                                          (interest) => Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              interest,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Like/Dislike indicators
                          if (_isDragging) ..[
                            if (_dragOffset.dx > 50)
                              Positioned(
                                top: 50,
                                left: 30,
                                child: Transform.rotate(
                                  angle: -0.3,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 4,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'LIKE',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (_dragOffset.dx < -50)
                              Positioned(
                                top: 50,
                                right: 30,
                                child: Transform.rotate(
                                  angle: 0.3,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.red,
                                        width: 4,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'NOPE',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Action buttons
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: 'dislike',
                onPressed: _handleDislike,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 32,
                ),
              ),
              const SizedBox(width: 20),
              FloatingActionButton(
                heroTag: 'superlike',
                onPressed: () {},
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.star,
                  color: Colors.blue,
                  size: 32,
                ),
              ),
              const SizedBox(width: 20),
              FloatingActionButton(
                heroTag: 'like',
                onPressed: _handleLike,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}