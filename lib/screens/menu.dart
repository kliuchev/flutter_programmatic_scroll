import 'package:flutter/material.dart';
import 'package:flutter_programmatic_scroll/main.dart';
import 'package:flutter_programmatic_scroll/screens/screen_four.dart';
import 'package:flutter_programmatic_scroll/screens/screen_one.dart';
import 'package:flutter_programmatic_scroll/screens/screen_three.dart';
import 'package:flutter_programmatic_scroll/screens/screen_two.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programmatic scroll'),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text(
              "Here are some examples of programmatic scrolling.",
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Screen one'),
            subtitle: const Text('Scrollable'),
            onTap: () => _push(
              context,
              const ScreenOne(longContent),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: const Text('Screen two'),
            subtitle: const Text('Scrollable + SingleChildScrollView'),
            onTap: () => _push(
              context,
              const ScreenTwo(longContent),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: const Text('Screen three'),
            subtitle: const Text('Large lists'),
            onTap: () => _push(
              context,
              ScreenThree(FixedSizeItemData.data),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: const Text('Screen four'),
            subtitle: const Text('Precalculations'),
            onTap: () => _push(
              context,
              const ScreenFour(longContent),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
