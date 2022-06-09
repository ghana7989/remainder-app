import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:reminder/models/common/custom_icon.dart';

class CustomIconCollection {
  final List<CustomIcon> _icons = [
    CustomIcon(id: 'bars', icon: CupertinoIcons.bars),
    CustomIcon(id: 'alarm', icon: CupertinoIcons.alarm),
    CustomIcon(id: 'airplane', icon: CupertinoIcons.airplane),
    CustomIcon(id: 'calendar_today', icon: CupertinoIcons.calendar_today),
    CustomIcon(id: 'waveform_path', icon: CupertinoIcons.waveform_path),
    CustomIcon(id: 'person', icon: CupertinoIcons.person),
  ];

  UnmodifiableListView<CustomIcon> get icons => UnmodifiableListView(_icons);

  CustomIcon findIconById(String id) {
    return _icons.firstWhere((element) => element.id == id);
  }
}
