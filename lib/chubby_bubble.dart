// Copyright (c) 2023, the ChubbyBubble project authors.  Please see the AUTHORS
// file for details. All rights reserved. Use of this source code is governed by
// a BSD-style license that can be found in the LICENSE file.

/// A toolkit for building beautiful terminal user interfaces.
///
/// ChubbyBubble was designed to be extensive and simple to use. Presently, the
/// only available module is the [panel] module. This can be invoked using the
/// [ChubbyBubble.panel] constructor.
library chubby_bubble;

import 'dart:io';

import 'package:chubby_bubble/common/widget.dart';
import 'package:dart_console/dart_console.dart';

export 'package:dart_console/dart_console.dart' show TextAlignment;

export 'common/ansi.dart' show AnsiStyle, AnsiColor, AnsiExtension;
export 'common/text_style.dart' show ChubbyTextStyle;
export 'features/panel/panel.dart'
    show
        ChubbyPanel,
        CornerStyle,
        EdgeStyle,
        ChubbyPanelStyle,
        ChubbyPanelTitle;

/// The main entry-point to [ChubbyBubble]. Use the named constructor(s) to
/// generate available objects and render them to the console.
class ChubbyBubble {
  static final Console _console = Console();
  static final StringBuffer _buffer = StringBuffer();

  const ChubbyBubble({required this.child});

  final ChubbyWidget child;

  void render() {
    final int consoleWidthIncludingPanel = stdout.terminalColumns - 4;
    child.render(
      _buffer,
      consoleWidthIncludingPanel,
    );
    _console.write(_buffer.toString());
    _buffer.clear();
  }
}
