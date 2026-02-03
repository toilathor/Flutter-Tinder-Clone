class CardSwiperDirection {
  final double angle;

  final String name;

  const CardSwiperDirection._({
    required this.angle,
    required this.name,
  });

  static const none = CardSwiperDirection._(
    angle: double.infinity,
    name: 'none',
  );

  static const top = CardSwiperDirection._(angle: 0, name: 'top');

  static const right = CardSwiperDirection._(angle: 90, name: 'right');

  static const bottom = CardSwiperDirection._(angle: 180, name: 'bottom');

  static const left = CardSwiperDirection._(angle: 270, name: 'left');

  factory CardSwiperDirection.custom(double angle, {String? name}) {
    final normalizedAngle = (angle % 360 + 360) % 360;
    final directionName = name ?? _getDirectionName(normalizedAngle);
    return CardSwiperDirection._(
      angle: normalizedAngle,
      name: directionName,
    );
  }

  static String _getDirectionName(double angle) {
    if (angle == 0) return 'top';
    if (angle == 90) return 'right';
    if (angle == 180) return 'bottom';
    if (angle == 270) return 'left';

    // For custom angles, generate a name based on the quadrant
    if (angle > 0 && angle < 90) return 'top-right';
    if (angle > 90 && angle < 180) return 'right-bottom';
    if (angle > 180 && angle < 270) return 'bottom-left';
    return 'left-top';
  }

  bool isCloseTo(CardSwiperDirection other, {double tolerance = 5}) {
    final diff = (angle - other.angle).abs();
    return diff <= tolerance || (360 - diff) <= tolerance;
  }

  bool get isHorizontal => isCloseTo(right) || isCloseTo(left);

  bool get isVertical => isCloseTo(top) || isCloseTo(bottom);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CardSwiperDirection &&
        other.angle == angle &&
        other.name == name;
  }

  @override
  int get hashCode => Object.hash(angle, name);

  @override
  String toString() => 'CardSwiperDirection($name: $angle°)';
}
