import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';

ToastFuture buildShowToast(BuildContext context) {
  return showToast(
    "Required,All Fields Are Required",
    textStyle: GoogleFonts.aDLaMDisplay(color: Colors.grey),
    context: context,
    animation: StyledToastAnimation.rotate,
    reverseAnimation: StyledToastAnimation.fade,
    position: const StyledToastPosition(
        align: Alignment.bottomCenter, offset: 50),
    animDuration: const Duration(seconds: 2),
    duration: const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
    backgroundColor: const Color.fromRGBO(249, 249, 224, 0.6),
  );
}