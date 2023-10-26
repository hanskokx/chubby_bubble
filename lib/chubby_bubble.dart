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

/// The main entry-point to [ChubbyBubble]. Use the named constructor(s) to
/// generate available objects and render them to the console.
class ChubbyBubble {
  static final Console _console = Console();

  const ChubbyBubble._();

  /// Creates a new [ChubbyPanel] and renders it to the console.
  ///
  /// # Rquired
  ///
  /// - `[String]`: The body text of the panel.
  ///
  /// # Optional
  ///
  /// - `[TextAlign] alignment`: Aligns the text within the panel. Has no effect
  /// if [width] is not specified.
  ///
  ///   - `TextAlign.left` (default): Aligns the panel to the left side
  ///   - `TextAlign.center`: Centers the panel within the available space
  ///   - `TextAlign.right`: Aligns the panel to the right side
  ///
  /// - `[ChubbyPanelTheme] theme`: Contains styling options for the edges and
  /// corners of the panel, as well as the background and border colors. This is
  /// also where you will find options for styling the text.
  ///
  /// - `[int] width`: Specify the maximum width of the panel. If no width is
  /// specified, the full console width is used.
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
      theme: theme,
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
