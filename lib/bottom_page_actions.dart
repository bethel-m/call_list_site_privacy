import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> urlLaunch(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, webOnlyWindowName: '_self')) {
    throw Exception('Could not launch $url');
  }
}

const home = "https://bethel-m.github.io/Call_list_site/";
const contact = "https://bethel-m.github.io/Call_list_site/Contact";
const privacy = "https://bethel-m.github.io/Call_list_site/Privacy";
const terms = "https://bethel-m.github.io/Call_list_site/terms";

class BottomPageActions extends StatelessWidget {
  const BottomPageActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsetsDirectional.symmetric(vertical: 24, horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "©Bethel  2025",
            style: TextStyle(),
          ),
          const SizedBox(width: 24),
          BottomLink(
            tooltip: home,
            linkName: "Home",
            onPressed: () {
              urlLaunch(home);
            },
          ),
          BottomLink(
            tooltip: contact,
            linkName: "Contact",
            onPressed: () {
              urlLaunch(contact);
            },
          ),
          // const SizedBox(width: 24),
          // BottomLink(
          //   tooltip: "https://bethel-m.github.io/Call_list_site/ChangeLog",
          //   linkName: "Change Log",
          //   onPressed: () {
          //     context.go(ChangeLogScreen.path);
          //   },
          // ),
          const SizedBox(width: 24),
          BottomLink(
            tooltip: privacy,
            linkName: "Privacy",
            onPressed: () {},
          ),
          const SizedBox(width: 24),
          BottomLink(
            tooltip: terms,
            linkName: "TOS",
            onPressed: () {
              urlLaunch(terms);
            },
          ),
        ],
      ),
    );
  }
}

class BottomLink extends StatelessWidget {
  const BottomLink({
    super.key,
    required this.tooltip,
    required this.linkName,
    required this.onPressed,
  });
  final String tooltip;
  final String linkName;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            linkName,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
              color: Colors.white,
            ),
          )),
    );
  }
}
