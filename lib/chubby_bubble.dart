// Copyright (c) 2023, the ChubbyBubble project authors.  Please see the AUTHORS
// file for details. All rights reserved. Use of this source code is governed by
// a BSD-style license that can be found in the LICENSE file.

/// A toolkit for building beautiful terminal user interfaces.
///
/// ChubbyBubble was designed to be extensive and simple to use. Presently, the
/// only available module is the [panel] module. This can be invoked using the
/// [ChubbyBubble.panel] constructor.
library chubby_bubble;

import 'package:chubby_bubble/features/panel/panel.dart';
import 'package:dart_console/dart_console.dart';

export 'package:dart_console/dart_console.dart' show TextAlignment;

export 'common/ansi.dart' show AnsiStyle, AnsiColor, AnsiExtension;
export 'common/text_style.dart' show ChubbyTextStyle;
export 'features/panel/panel.dart'
    show
        ChubbyPanel,
        CornerStyle,
        EdgeStyle,
        ChubbyPanelTheme,
        ChubbyPanelTitle;

class ChubbyBubble {
  static final Console _console = Console();
  const ChubbyBubble._();

  static void panel(
    String text, {
    ChubbyPanelTheme theme = const ChubbyPanelTheme(),
    ChubbyPanelTitle? title,
    int? width,
    TextAlignment alignment = TextAlignment.left,
  }) {
    ChubbyPanel(
      text,
      alignment: alignment,
      style: theme,
      width: width,
      title: title != null
          ? ChubbyPanelTitle(
              title.text,
              theme: title.theme,
            )
          : null,
    ).render(_console);
  }
}
