import 'dart:developer' as logger show log;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class MenuPicker extends StatefulWidget {
  final int selectedIndex;
  final List<Widget> children;
  // final FixedExtentScrollController scrollController;

  const MenuPicker({
    super.key,
    required this.selectedIndex,
    required this.children,
    // required this.scrollController,
  });

  @override
  State<MenuPicker> createState() => _MenuPickerState();
}

class _MenuPickerState extends State<MenuPicker> {
  late int _selectedIndex = widget.selectedIndex;
  late final FixedExtentScrollController _scrollController =
      FixedExtentScrollController(initialItem: widget.selectedIndex);

  @override
  void dispose() {
    // widget.scrollController.dispose();
    if (kDebugMode) {
      logger.log('MENU_PICKER: Dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;

    if (kDebugMode) {
      logger.log('MENU_PICKER: Rebuild');
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: deviceHeight / 3,
          margin: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 18,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(
                        top: 14, left: 14, right: 12, bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(-1, -1),
                            blurRadius: 4,
                            spreadRadius: 1,
                            color: Colors.tealAccent.withOpacity(0.42)),
                        BoxShadow(
                            offset: const Offset(1, 1),
                            blurRadius: 4,
                            spreadRadius: 1,
                            color: Colors.tealAccent.withOpacity(0.42))
                      ],
                    ),
                    child: const Icon(
                      Icons.task_alt_rounded,
                      size: 26,
                      color: Colors.black54,
                      semanticLabel: 'ic_date_range_rencana',
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Hero(
                          tag: 'menu_title',
                          transitionOnUserGestures: true,
                          child: Text(
                            'Select Menu',
                            style: textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Divider(height: 12, endIndent: 24),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      logger.log('MENU_PICKER-Pop: '
                          'selected menu index >> $_selectedIndex');
                    }
                    Navigator.of(context).pop(_selectedIndex);
                  },
                  child: Hero(
                    tag: 'selected_menu_label',
                    transitionOnUserGestures: true,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: CupertinoPicker(
                        scrollController: _scrollController,
                        // scrollController: widget.scrollController,
                        looping: true,
                        itemExtent: 50.0,
                        backgroundColor: Colors.white,
                        children: widget.children,
                        onSelectedItemChanged: (int index) {
                          _selectedIndex = index;
                          if (kDebugMode) {
                            logger.log(
                                'MENU_PICKER-ItemChange: Index Change >> $index');
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
