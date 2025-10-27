import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormattedText extends StatelessWidget {
  final String text;

  const FormattedText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _parseText(text),
    );
  }

  TextSpan _parseText(String text) {
    final List<TextSpan> spans = [];
    final baseStyle = GoogleFonts.inter(color: Colors.white, fontSize: 14);
    
    // Split by ** for bold
    final parts = text.split('**');
    
    for (int i = 0; i < parts.length; i++) {
      if (i % 2 == 0) {
        // Regular text
        spans.add(TextSpan(text: parts[i], style: baseStyle));
      } else {
        // Bold text
        spans.add(TextSpan(
          text: parts[i], 
          style: baseStyle.copyWith(fontWeight: FontWeight.bold)
        ));
      }
    }
    
    return TextSpan(children: spans);
  }
}