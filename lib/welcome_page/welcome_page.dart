import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111b21),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Image.asset(
                  '/Users/boj/Desktop/whatsapp-clone/whatsapp_clone/assets/images/circle.png',
                  color: const Color(0xff00a884),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Welcome to Whatsapp',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                          text: 'Read our ',
                          style: TextStyle(
                            color: Color(0xff8696a0),
                          ),
                          children: [
                            TextSpan(
                              text: 'Privacy Policy. ',
                              style: TextStyle(
                                color: Color(0xff53bdeb),
                              ),
                            ),
                            TextSpan(
                                text: 'Tap "Agree and continue" to accept the'),
                            TextSpan(
                              text: 'Terms of Services.',
                              style: TextStyle(
                                color: Color(0xff53bdeb),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 42,
                    width: MediaQuery.of(context).size.width - 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff00a884),
                        foregroundColor: const Color(0xff111b21),
                        splashFactory: NoSplash.splashFactory,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                      child: const Text('AGREE AND CONTINUE'),
                    ),
                  ),
                  Material(
                    color: const Color(0xff182229),
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: const Color(0xff09141a),
                      child: const Row(
                        children: [
                          Icon(Icons.language),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
