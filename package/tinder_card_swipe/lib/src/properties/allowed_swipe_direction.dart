class AllowedSwipeDirection {
  const AllowedSwipeDirection.all()
      : up = true,
        down = true,
        right = true,
        left = true;

  const AllowedSwipeDirection.none()
      : up = false,
        down = false,
        right = false,
        left = false;

  const AllowedSwipeDirection.only({
    this.up = false,
    this.down = false,
    this.left = false,
    this.right = false,
  });

  const AllowedSwipeDirection.symmetric({
    bool horizontal = false,
    bool vertical = false,
  })  : up = vertical,
        down = vertical,
        left = horizontal,
        right = horizontal;

  final bool up;
  final bool down;
  final bool left;
  final bool right;
}
