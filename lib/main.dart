import 'dart:developer' as logger show log;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'menu_picker.dart';
import 'hero_dialog_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Demo Cupertino Picker'),
    );
  }
}

final List<String> listMenu = [
  'Choose Menu',
  'Menu 1',
  'Menu 2',
  'Menu 3',
  'Menu 4',
  'Menu 5',
];

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  int _currentMenuIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'menu_title',
              transitionOnUserGestures: true,
              child: Text(
                'Selected Menu',
                style: _textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 14),
            Hero(
              tag: 'selected_menu_label',
              transitionOnUserGestures: true,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  elevation: 0,
                  child: InkWell(
                    onTap: () async {
                      final selectedMenuIndex =
                          await Navigator.of(context).push<int>(
                        HeroDialogRoute(
                          builder: (context) => MenuPicker(
                            selectedIndex: _currentMenuIndex,
                            // scrollController: FixedExtentScrollController(
                            //     initialItem: _currentMenuIndex),
                            children: List<Widget>.generate(
                              listMenu.length,
                              (int index) => Center(
                                child: Text(listMenu[index].toUpperCase()),
                              ),
                            ),
                          ),
                        ),
                      );

                      if (kDebugMode) {
                        logger.log(
                            'MAIN: Selected Menu Index >> $selectedMenuIndex');
                      }
                      if (selectedMenuIndex != null &&
                          selectedMenuIndex != _currentMenuIndex) {
                        setState(() => _currentMenuIndex = selectedMenuIndex);
                      }
                    },
                    borderRadius: BorderRadius.circular(11),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: Text(
                        listMenu[_currentMenuIndex],
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
