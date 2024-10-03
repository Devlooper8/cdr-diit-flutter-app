import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../themes.controller.dart';
import 'drawer.controller.dart' as custom;

class CdrDrawer extends GetWidget<custom.DrawerController> {
  const CdrDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    // Get the drawer controller
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
            const SizedBox(height: 25),
            SizedBox(
              height: 200,
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is UserScrollNotification) {
                    controller.setUserInteracting(
                      scrollNotification.direction != ScrollDirection.idle,
                    );
                  }
                  return false;
                },
                child: Obx(() {
                  return PageView(
                    controller: controller.pageController,
                    onPageChanged: (index) {
                      controller.switchWebsite(index == 0 ? 'cdr' : 'diit');
                    },
                    children: [
                      LogoPage(
                        website: 'cdr',
                        imagePath: 'assets/images/cdr_logo.png',
                        offset: -30,
                        hintShiftAmount: -10,
                        isSelected: controller.selectedWebsite.value == 'cdr',
                        isUserInteracting: controller.isUserInteracting.value,
                      ),
                      LogoPage(
                        website: 'diit',
                        imagePath: 'assets/images/diit_logo.png',
                        offset: 30,
                        hintShiftAmount: 10,
                        isSelected: controller.selectedWebsite.value == 'diit',
                        isUserInteracting: controller.isUserInteracting.value,
                      ),
                    ],
                  );
                }),
              ),
            ),
            // Bookmarks button
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
                  Get.back();
                  Get.toNamed('/bookmarks');
                },
                icon: const Icon(Icons.bookmark, color: Colors.black),
                label: const Text(
                  "Bookmarks",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Theme toggle button
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
              child: Obx(() {
                return TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0x33FFFFFF),
                  ),
                  onPressed: controller.toggleTheme,
                  icon: Icon(
                    themeController.isDarkMode.value
                        ? Icons.nights_stay
                        : Icons.wb_sunny,
                    color: Colors.black,
                  ),
                  label: Text(
                    themeController.isDarkMode.value ? "Dark Mode" : "Light Mode",
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }),
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
    final drawerController = Get.find<custom.DrawerController>();

    return GestureDetector(
      onTap: () {
        drawerController.switchWebsite(website);
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
  final double hintShiftAmount;
  final bool isUserInteracting;

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isSelected && !widget.isUserInteracting) {
        _runHintAnimation();
      }
    });

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
      _shiftAnimation = Tween<double>(begin: 0, end: widget.hintShiftAmount)
          .animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      );
    }

    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected && !widget.isUserInteracting) {
        _runHintAnimation();
      } else {
        _animationController.reset();
      }
    }

    if (widget.isUserInteracting != oldWidget.isUserInteracting) {
      if (!widget.isUserInteracting && widget.isSelected) {
        _runHintAnimation();
      } else if (widget.isUserInteracting) {
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
