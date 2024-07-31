import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
  });

  showButtomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: COLORS.greyBackground.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      iconSize: 22,
                      splashRadius: 22,
                      splashColor: Colors.transparent,
                      constraints: const BoxConstraints(maxWidth: 40),
                      icon: const Icon(
                        Icons.close_outlined,
                        color: COLORS.greyDark,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'App Language',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff182229),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => showButtomSheet(context),
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
