import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/models/app_router.dart';
import 'package:whatsapp_clone/common/models/app_routes.dart';
import 'package:whatsapp_clone/common/models/user_model.dart';
import 'package:whatsapp_clone/common/providers/locale_provider.dart';
import 'package:whatsapp_clone/common/utils/app_colors.dart';
import 'package:whatsapp_clone/common/utils/snack_bar.dart';
import 'package:whatsapp_clone/common/widgets/bottom_nav_bar.dart';
import 'package:whatsapp_clone/common/providers/current_user.dart';
import 'package:whatsapp_clone/main.dart';
import 'package:whatsapp_clone/modules/screens/home_page/widgets/chat_type_button.dart';
import 'package:whatsapp_clone/modules/screens/home_page/widgets/new_chat_list_tile.dart';

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

  showButtomSheet(context, String userName) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          final localeProv = ref.read(localeProvider.notifier);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(child: Text('New chat')),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) {},
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
                    contentPadding: EdgeInsets.zero,
                    fillColor: const Color.fromRGBO(50, 50, 50, 0.8),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.greyBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                  child: const Column(
                    children: [
                      NewChatListTile(
                        icon: Icons.people,
                        title: 'New group',
                      ),
                      NewChatListTile(
                        icon: Icons.group_add_rounded,
                        title: 'New contact',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.greyBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        List<DocumentSnapshot> docs = snapshot.data!.docs;

                        return ListView.builder(
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              var user = docs[index];
                              debugPrint("$userName + ${user['username']}");
                              // if (user['username'].toString().trim() ==
                              //     userName.toString().trim()) {
                              return ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user['profileImageUrl']),
                                  radius: 15,
                                ),
                                title: Text(user['username']),
                                subtitle: Text(user['phoneNumber']),
                                onTap: () async {
                                  try {
                                    final DocumentSnapshot userDoc =
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user['uid'])
                                            .get();
                                    UserModel receiver = UserModel.fromMap(
                                        userDoc.data() as Map<String, dynamic>);
                                    AppRouter.push(AppRoutes.chatScreen,
                                        arguments: receiver);
                                  } catch (e) {
                                    showSnackBar(context,
                                        content: e.toString());
                                  }
                                },
                              );
                            }
                            //},
                            );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

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
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz_outlined,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          const Icon(Icons.camera_alt_rounded, size: 25, color: Colors.white),
          const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () => showButtomSheet(context, userInfo!.username),
                icon: const Icon(Icons.add_circle,
                    size: 33, color: Color.fromARGB(255, 58, 241, 144))),
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
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
