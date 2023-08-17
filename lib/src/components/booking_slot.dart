import 'package:flutter/material.dart';

class BookingSlot extends StatelessWidget {
  const BookingSlot({
    Key? key,
    required this.child,
    required this.isBooked,
    required this.onTap,
    required this.isSelected,
    required this.isPauseTime,
    this.bookedSlotColor,
    this.selectedSlotColor,
    this.availableSlotColor,
    this.pauseSlotColor,
    this.hideBreakSlot,
    required this.totalPositions,
    required this.filledPositions,
  }) : super(key: key);

  final Widget child;
  final bool isBooked;
  final bool isPauseTime;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? bookedSlotColor;
  final Color? selectedSlotColor;
  final Color? availableSlotColor;
  final Color? pauseSlotColor;
  final bool? hideBreakSlot;
  final int totalPositions;
  final int filledPositions;

  Color calculatePositionColor() {
    double percentage = (totalPositions - filledPositions) / totalPositions;
    if (percentage <= 0.1) {
      return Colors.red.withOpacity(0.7);
    } else if (percentage <= 0.3) {
      return Colors.yellow.withOpacity(0.7);
    } else {
      return Colors.green.withOpacity(0.7);
    }
  }

  String availableSlotsText() {
    int remaining = totalPositions - filledPositions;
    return '$filledPositions / $totalPositions';
  }

  @override
  Widget build(BuildContext context) {
    final slotColor = calculatePositionColor();
    final percentage = filledPositions / totalPositions;

    return (hideBreakSlot != null && hideBreakSlot == true && isPauseTime)
        ? const SizedBox()
        : InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: FractionallySizedBox(
                  widthFactor: 1 - percentage,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ),
              FractionallySizedBox(
                alignment: Alignment.centerRight,
                widthFactor: percentage,
                child: Container(
                  color: slotColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      child,
                      Text(availableSlotsText()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
      ),
    );
  }
}