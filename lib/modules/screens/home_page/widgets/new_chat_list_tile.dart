import 'package:flutter/material.dart';

class NewChatListTile extends StatelessWidget {
  const NewChatListTile({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('$title clicked');
      },
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 62, 68, 72),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(child: Icon(icon)),
        ),
        title: Text(title),
        subtitle: Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
      ),
    );
  }
}
