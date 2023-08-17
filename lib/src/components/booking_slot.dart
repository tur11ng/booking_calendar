import 'package:booking_calendar/src/components/common_card.dart';
import 'package:flutter/material.dart';

class BookingSlot extends StatelessWidget {
  const BookingSlot({
    Key? key,
    required this.child,
    required this.isBooked,
    required this.onTap,
    required this.isSelected,
    required this.isPauseTime,
    required this.totalPositions,
    required this.filledPositions,
    this.bookedSlotColor,
    this.selectedSlotColor,
    this.availableSlotColor,
    this.pauseSlotColor,
    this.hideBreakSlot,
  }) : super(key: key);

  final Widget child;
  final bool isBooked;
  final bool isPauseTime;
  final bool isSelected;
  final bool? hideBreakSlot;
  final int totalPositions;
  final int filledPositions;
  final VoidCallback onTap;
  final Color? bookedSlotColor;
  final Color? selectedSlotColor;
  final Color? availableSlotColor;
  final Color? pauseSlotColor;

  Color getSlotColor() {
    if (isPauseTime) {
      return pauseSlotColor ?? Colors.grey;
    }

    if (isBooked) {
      return bookedSlotColor ?? Colors.redAccent;
    } else {
      return isSelected
          ? selectedSlotColor ?? Colors.orangeAccent
          : availableSlotColor ?? calculatePositionColors(); // modified
    }
  }

  // added
  Color calculatePositionColors() {
    int remainingPositions = totalPositions - filledPositions;
    if (remainingPositions <= 2) {
      return Colors.red;
    } else if (remainingPositions <= 4) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (hideBreakSlot != null && hideBreakSlot == true && isPauseTime)
        ? const SizedBox()
        : GestureDetector(
            onTap: (!isBooked && !isPauseTime) ? onTap : null,
            child: CommonCard(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                color: getSlotColor(),
                child: child),
          );
  }
}
