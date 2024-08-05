import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/providers/locale_provider.dart';
import 'package:whatsapp_clone/common/utils/Colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageButton extends ConsumerStatefulWidget {
  const LanguageButton({
    super.key,
  });

  @override
  ConsumerState<LanguageButton> createState() => _LanguageButtonState();
}

class _LanguageButtonState extends ConsumerState<LanguageButton> {
  int selectedValue = 0;
  String selectedLanguage = 'English';

  showButtomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          final localeProv = ref.read(localeProvider.notifier);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 30,
                  decoration: BoxDecoration(
                    color: kColors.greyDark.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      padding: EdgeInsets.zero,
                      iconSize: 22,
                      splashRadius: 22,
                      splashColor: Colors.transparent,
                      constraints: const BoxConstraints(maxWidth: 40),
                      icon: const Icon(
                        Icons.close_outlined,
                        color: kColors.greyDark,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.appLang,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  color: kColors.greyDark.withOpacity(0.5),
                  thickness: 0.5,
                ),
                RadioListTile(
                  value: 0,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                      selectedLanguage = 'English';
                      localeProv.setLocale(const Locale('en'));
                    });
                  },
                  activeColor: kColors.greenDark,
                  title: const Text('English'),
                  subtitle: const Text(
                    "(phone's language)",
                    style: TextStyle(
                      color: kColors.greyDark,
                    ),
                  ),
                ),
                RadioListTile(
                  value: 1,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                      selectedLanguage = 'Arabic';
                      localeProv.setLocale(const Locale('ar'));
                    });
                  },
                  activeColor: kColors.greenDark,
                  title: const Text('Arabic'),
                ),
                const SizedBox(height: 10),
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
              const Icon(Icons.language, color: kColors.greenDark),
              const SizedBox(width: 10),
              Text(selectedLanguage),
              const SizedBox(width: 10),
              const Icon(Icons.keyboard_arrow_down, color: kColors.greenDark),
            ],
          ),
        ),
      ),
    );
  }
}
