import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static final textTheme = TextTheme(
    displayLarge: GoogleFonts.roboto(
        fontSize: 113.sp, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    displayMedium: GoogleFonts.roboto(
      fontSize: 70.sp,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: Colors.black,
    ),
    displaySmall: GoogleFonts.roboto(
      fontSize: 56.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    headlineMedium: GoogleFonts.roboto(
      fontSize: 40.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.black,
    ),
    headlineSmall: GoogleFonts.roboto(
      fontSize: 28.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: 23.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 19.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    titleSmall: GoogleFonts.roboto(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  );
}
