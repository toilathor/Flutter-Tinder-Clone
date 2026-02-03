import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../card_animation.dart';
import '../controller/card_swiper_controller.dart';
import '../controller/controller_event.dart';
import '../direction/card_swiper_direction.dart';
import '../enums.dart';
import '../properties/allowed_swipe_direction.dart';
import '../typedefs.dart';
import '../utils/number_extension.dart';
import '../utils/undoable.dart';

part 'card_swiper_state.dart';

class CardSwiper extends StatefulWidget {
  final NullableCardBuilder cardBuilder;
  final int cardsCount;
  final int initialIndex;
  final CardSwiperController? controller;
  final Duration duration;
  final EdgeInsetsGeometry padding;
  final double maxAngle;
  final int threshold;
  final double scale;
  final bool isDisabled;
  final CardSwiperOnSwipe? onSwipe;
  final CardSwiperOnEnd? onEnd;
  final CardSwiperOnTapDisabled? onTapDisabled;
  final AllowedSwipeDirection allowedSwipeDirection;
  final CardSwiperOnUndo? onUndo;
  final CardSwiperDirectionChange? onSwipeDirectionChange;
  final Offset backCardOffset;
  final UndoDirection undoDirection;
  final bool showBackCardOnUndo;
  final double undoSwipeThreshold;

  const CardSwiper({
    required this.cardBuilder,
    required this.cardsCount,
    this.controller,
    this.initialIndex = 0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
    this.duration = const Duration(milliseconds: 200),
    this.maxAngle = 30,
    this.threshold = 50,
    this.scale = 0.9,
    this.isDisabled = false,
    this.onTapDisabled,
    this.onSwipe,
    this.onEnd,
    this.onSwipeDirectionChange,
    this.allowedSwipeDirection = const AllowedSwipeDirection.all(),
    this.onUndo,
    this.backCardOffset = const Offset(0, 40),
    this.undoDirection = UndoDirection.left,
    this.showBackCardOnUndo = false,
    this.undoSwipeThreshold = 50.0,
    super.key,
  })  : assert(
          maxAngle >= 0 && maxAngle <= 360,
          'maxAngle must be between 0 and 360',
        ),
        assert(
          threshold >= 1 && threshold <= 100,
          'threshold must be between 1 and 100',
        ),
        assert(
          scale >= 0 && scale <= 1,
          'scale must be between 0 and 1',
        ),
        assert(
          initialIndex >= 0 && initialIndex < cardsCount,
          'initialIndex must be between 0 and [cardsCount]',
        ),
        assert(
          undoSwipeThreshold >= 0,
          'undoSwipeThreshold must be a positive value',
        );

  @override
  State createState() => _CardSwiperState();
}
