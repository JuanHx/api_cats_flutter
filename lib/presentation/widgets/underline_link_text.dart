import 'package:api_cats_app/presentation/pages/web_view_page.dart';
import 'package:flutter/material.dart';

class UnderlinedLinkText extends StatelessWidget {
  final String text;
  final String url;

  const UnderlinedLinkText({super.key, required this.text, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WebViewPage(title: text, url: url),
          ),
        );
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          decoration: TextDecoration.underline,
          color: Color(0xFF7760C0),
          fontWeight: FontWeight.bold,
          fontFamily: 'Plus Jakarta Sans',
        ),
      ),
    );
  }
}
