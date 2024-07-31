import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff182229),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: const Color(0xff09141a),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.language, color: COLORS.greenDark),
              const SizedBox(width: 10),
              Text('English'),
              const SizedBox(width: 10),
              Icon(Icons.keyboard_arrow_down, color: COLORS.greenDark),
            ],
          ),
        ),
      ),
    );
  }
}
