import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/models/app_router.dart';
import 'package:whatsapp_clone/common/models/app_routes.dart';
import 'package:whatsapp_clone/modules/auth/auth.dart';
import 'package:whatsapp_clone/common/providers/current_user.dart';
import 'package:whatsapp_clone/modules/welcome/screens/welcome_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isThereArchived = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late String userName;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(CurrentUserProvider.notifier).loadCurrentUser();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(CurrentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          userInfo != null ? userInfo.username : 'user',
          style: const TextStyle(fontSize: 17),
        ),
        centerTitle: true,
        leading: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return const WelcomePage();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.more_horiz_outlined,
              color: Colors.white,
            ),
          ),
        ),
        actions: const [
          Icon(Icons.camera_alt_rounded, size: 25, color: Colors.white),
          SizedBox(width: 20),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.add_circle,
                size: 33, color: Color.fromARGB(255, 58, 241, 144)),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chats',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: TextField(
                  onChanged: null,
                  onTap: () {
                    _focusNode.requestFocus();
                  },
                  focusNode: _focusNode,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    fillColor: const Color.fromRGBO(50, 50, 50, 0.8),
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ChatTypeButton(title: 'All'),
                      SizedBox(width: 10),
                      ChatTypeButton(title: 'Unread'),
                      SizedBox(width: 10),
                      ChatTypeButton(title: 'Favorite'),
                      SizedBox(width: 10),
                      ChatTypeButton(title: 'Groups')
                    ],
                  ),
                ),
              ),
              isThereArchived
                  ? const Text('Archived')
                  : const SizedBox.shrink(),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  // Sample chat items
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                      maxRadius: 20,
                    ),
                    title: Text('+234 700 000 0000'),
                    subtitle: Text('May I know you?'),
                    trailing: Text('23:03'),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                      maxRadius: 20,
                    ),
                    title: Text('Cubbie'),
                    subtitle: Text('1:55'),
                    trailing: Text('22:45'),
                  ),

                  // Add more ListTiles here
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    _auth.signOut();
                    AppRouter.pushReplacement(AppRoutes.authScreen);
                  },
                  child: const Text('log out')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.update)),
        BottomNavigationBarItem(icon: Icon(Icons.call_sharp)),
        BottomNavigationBarItem(icon: Icon(Icons.people_outline)),
        BottomNavigationBarItem(icon: Icon(Icons.chat)),
        BottomNavigationBarItem(icon: Icon(Icons.settings_outlined)),
      ]),
    );
  }
}

class ChatTypeButton extends StatelessWidget {
  const ChatTypeButton({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(50, 50, 50, 0.8),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
