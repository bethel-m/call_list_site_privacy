import 'package:call_list_privacy/bottom_page_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

const String assetName = 'assets/svg/my_icon.svg';
final Widget svg = SvgPicture.asset(
  assetName,
  semanticsLabel: 'Dart Logo',
  width: 50,
  height: 50,
);
PreferredSizeWidget getAppBAr(
  BuildContext context,
) {
  return AppBar(
    scrolledUnderElevation: 0,
    foregroundColor: Colors.white,
    toolbarHeight: 100,
    //  leadingWidth: 500,
    // centerTitle: true,
    // TRY THIS: Try changing the color here to a specific color (to
    // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
    // change color while the other colors stay the same.
    backgroundColor: const Color(0xFF16181D),
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const HomeLogoWidget(),
          Flexible(
            child: Container(
              width: 700,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarAction(
                icon: Icons.person_2_outlined,
                toolTip: "contact",
                onPressed: () {
                  urlLaunch(contact);
                },
              ),
            ],
          )
        ]),
      ),
    ),
  );
}

class AppBarSpacing extends StatelessWidget {
  const AppBarSpacing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return const SizedBox(
          width: 100,
        );
      } else if (constraints.maxWidth < 900) {
        return const SizedBox(
          width: 700,
        );
      } else {
        return const SizedBox(
          width: 200,
        );
      }
    });
  }
}

class HomeLogoWidget extends StatelessWidget {
  const HomeLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: "Home",
        child: GestureDetector(
          onTap: () {
            urlLaunch(home);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              svg,
              const SizedBox(
                width: 12,
              ),
              const Text(
                "Call List",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarAction extends StatelessWidget {
  const AppBarAction({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.toolTip,
  });
  final String toolTip;
  final IconData icon;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: toolTip,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 35,
        ),
      ),
    );
  }
}
