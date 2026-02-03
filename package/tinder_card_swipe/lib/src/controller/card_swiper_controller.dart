import 'dart:async';

import '../direction/card_swiper_direction.dart';
import 'controller_event.dart';

class CardSwiperController {
  final _eventController = StreamController<ControllerEvent>.broadcast();

  Stream<ControllerEvent> get events => _eventController.stream;

  void swipe(CardSwiperDirection direction) {
    _eventController.add(ControllerSwipeEvent(direction));
  }

  void undo() {
    _eventController.add(const ControllerUndoEvent());
  }

  void moveTo(int index) {
    _eventController.add(ControllerMoveEvent(index));
  }

  Future<void> dispose() async {
    await _eventController.close();
  }
}
