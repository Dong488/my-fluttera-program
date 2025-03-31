import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BudgetProgressBar extends StatelessWidget {
  final double progress;
  final String budgetAmount;
  final double height,width;
  final Color progressColor;
  final Color backgroundColor;
  final bool showTextInside;

  const BudgetProgressBar({
    Key? key,
    required this.progress,
    required this.budgetAmount,
    this.height = 20,
    this.width=300,
    this.progressColor = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.showTextInside = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth * (progress / 100);
              return Container(
                width: barWidth,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
          if (showTextInside)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${progress}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$$budgetAmount',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}