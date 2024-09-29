import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class CdrDrawer extends StatefulWidget {
  const CdrDrawer({super.key});

  @override
  State<CdrDrawer> createState() => _CdrDrawerState();
}

class _CdrDrawerState extends State<CdrDrawer> {
  String selectedWebsite = 'cdr';
  bool isUserInteracting = false;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  int get selectedIndex => selectedWebsite == 'cdr' ? 0 : 1;

  void switchWebsite(String website) {
    setState(() {
      selectedWebsite = website;
    });
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 25,),
            SizedBox(
              height: 200,
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is UserScrollNotification) {
                    setState(() {
                      isUserInteracting = scrollNotification.direction != ScrollDirection.idle;
                    });
                  }
                  return false;
                },
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    if (index == 0) {
                      switchWebsite('cdr');
                    } else {
                      switchWebsite('diit');
                    }
                  },
                  children: [
                    LogoPage(
                      website: 'cdr',
                      imagePath: 'assets/images/cdr_logo.png',
                      offset: -30,
                      hintShiftAmount: -10,
                      isSelected: selectedWebsite == 'cdr',
                      isUserInteracting: isUserInteracting,
                    ),
                    LogoPage(
                      website: 'diit',
                      imagePath: 'assets/images/diit_logo.png',
                      offset: 30,
                      hintShiftAmount: 10,
                      isSelected: selectedWebsite == 'diit',
                      isUserInteracting: isUserInteracting,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 42,
              width: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 5,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0x33FFFFFF),
                ),
                onPressed: () {
                  // Perform the action for bookmarks here
                  Get.toNamed('/bookmarks');
                },
                icon: const Icon(Icons.bookmark, color: Colors.black),
                label: const Text(
                  "Bookmarks",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ),
          ],
        ),
      ),
    );
  }
}

class LogoPage extends StatelessWidget {
  final String website;
  final String imagePath;
  final double offset;
  final double hintShiftAmount;
  final bool isSelected;
  final bool isUserInteracting;

  const LogoPage({
    super.key,
    required this.website,
    required this.imagePath,
    required this.offset,
    required this.hintShiftAmount,
    required this.isSelected,
    required this.isUserInteracting,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final parentState = context.findAncestorStateOfType<_CdrDrawerState>();
        parentState?.switchWebsite(website);
      },
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          transform: Matrix4.translationValues(
            offset * (isSelected ? 0 : 0.8),
            0,
            0,
          ),
          child: AnimatedScale(
            scale: isSelected ? 1.2 : 0.8,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: AnimatedOpacity(
              opacity: isSelected ? 1 : 0.6,
              duration: const Duration(milliseconds: 500),
              child: AnimatedLogo(
                imagePath: imagePath,
                isSelected: isSelected,
                hintShiftAmount: hintShiftAmount,
                isUserInteracting: isUserInteracting,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends StatefulWidget {
  final String imagePath;
  final bool isSelected;
  final double hintShiftAmount; // Positive for right, negative for left
  final bool isUserInteracting; // Flag to control animation

  const AnimatedLogo({
    super.key,
    required this.imagePath,
    required this.isSelected,
    required this.hintShiftAmount,
    required this.isUserInteracting,
  });

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shiftAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _shiftAnimation = Tween<double>(begin: 0, end: widget.hintShiftAmount)
        .animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start the animation immediately after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isSelected && !widget.isUserInteracting) {
        _runHintAnimation();
      }
    });

    // Start the periodic animation
    _startPeriodicAnimation();
  }

  void _startPeriodicAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (widget.isSelected && !widget.isUserInteracting) {
        _runHintAnimation();
      }
    });
  }

  void _runHintAnimation() {
    if (!_animationController.isAnimating) {
      _animationController.forward().then((_) {
        if (mounted) {
          _animationController.reverse();
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedLogo oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.hintShiftAmount != oldWidget.hintShiftAmount) {
      // Update the shift animation with the new hint shift amount
      _shiftAnimation = Tween<double>(begin: 0, end: widget.hintShiftAmount)
          .animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      );
    }

    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected && !widget.isUserInteracting) {
        // If now selected and user is not interacting, run the animation immediately
        _runHintAnimation();
      } else {
        // Reset animation if the logo is no longer selected
        _animationController.reset();
      }
    }

    // Check if user interaction has changed
    if (widget.isUserInteracting != oldWidget.isUserInteracting) {
      if (!widget.isUserInteracting && widget.isSelected) {
        // User stopped interacting, resume animation
        _runHintAnimation();
      } else if (widget.isUserInteracting) {
        // User started interacting, stop animation
        _animationController.reset();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shiftAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shiftAnimation.value, 0),
          child: child,
        );
      },
      child: Image.asset(
        widget.imagePath,
        width: 200,
        height: 200,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.low,
      ),
    );
  }
}
