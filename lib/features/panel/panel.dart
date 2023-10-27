import 'dart:io';

import 'package:chubby_bubble/chubby_bubble.dart';
import 'package:chubby_bubble/common/widget.dart';
import 'package:dart_console/dart_console.dart';

export 'classes/corner_style.dart' show CornerStyle;
export 'classes/edge_style.dart' show EdgeStyle;
export 'classes/panel_style.dart' show ChubbyPanelStyle;
export 'classes/panel_title.dart' show ChubbyPanelTitle;

class ChubbyPanel implements ChubbyWidget {
  final ChubbyPanelStyle style;
  final ChubbyPanelTitle? title;

  @override
  final String text;
  final int? width;
  final TextAlignment alignment;
  final AnsiColor? color;
  final ChubbyWidget? child;

  const ChubbyPanel({
    required this.text,
    this.style = const ChubbyPanelStyle(),
    this.title,
    this.width,
    this.alignment = TextAlignment.left,
    this.color = AnsiColor.brightWhite,
    this.child,
  });

  void _renderTitle(
    StringBuffer buffer,
    ChubbyPanelStyle style,
    ChubbyPanelTitle title,
    int width,
    int consoleWidth,
    int panelPadding, {
    AnsiColor? backgroundColor,
  }) {
    final ChubbyTextStyle? titleTextStyle = title.style.textStyle;
    String leftConnector = title.style.edgeStyle.vl;
    String rightConnector = title.style.edgeStyle.vr;

    if (style.edgeStyle != EdgeStyle.double &&
        title.style.edgeStyle == EdgeStyle.double) {
      leftConnector = title.style.edgeStyle.ovl;
      rightConnector = title.style.edgeStyle.ovr;
    }

    final List<String> titleText = [title.text];

    // Calculate width of title card
    int maxTitleCardWidth = ((width * 0.95) - 8).floor();
    final int titleTextLength = title.text.length;
    final bool shouldSplitText = titleTextLength > maxTitleCardWidth;

    if (shouldSplitText) {
      titleText.clear();
      titleText.addAll(_splitString(title.text, maxTitleCardWidth));
    }

    if (!shouldSplitText) {
      maxTitleCardWidth = titleTextLength;
    }

    // Title's top border
    buffer.write('  '.colorBackground(backgroundColor));
    buffer.write(
      title.style.cornerStyle.tl.colorForeground(title.style.borderColor),
    );
    buffer.write(
      (title.style.edgeStyle.x * (maxTitleCardWidth + 2))
          .colorForeground(title.style.borderColor),
    );
    buffer.write(
      title.style.cornerStyle.tr.colorForeground(title.style.borderColor),
    );

    final int remainingSpace = consoleWidth - width - panelPadding;
    buffer.write(
      (' ' * (remainingSpace + panelPadding + maxTitleCardWidth + 8))
          .colorBackground(backgroundColor),
    );
    buffer.writeln();

    // Title content
    for (final String titleLine in titleText) {
      final int textIndex = titleText.indexOf(titleLine);
      final bool isFirstLine = textIndex == 0;
      final bool isLastLine = textIndex == titleText.length - 1;

      if (isFirstLine) {
        buffer.write((' ' * panelPadding).colorBackground(backgroundColor));
        buffer.write(
          style.cornerStyle.tl.colorForeground(style.borderColor),
        );

        buffer.write(
          style.edgeStyle.x.colorForeground(style.borderColor),
        );
        buffer.write(
          leftConnector.colorForeground(style.borderColor),
        );
        buffer.write(' '.colorBackground(title.style.backgroundColor));
      }

      String line = titleLine
          .colorForeground(titleTextStyle?.color)
          .padLeft(1)
          .padRight(1)
          .colorBackground(title.style.backgroundColor);

      if (titleTextStyle?.bold ?? false) line = line.bold();
      if (titleTextStyle?.dim ?? false) line = line.dim();
      if (titleTextStyle?.italic ?? false) line = line.italic();
      if (titleTextStyle?.underline ?? false) line = line.underline();
      if (titleTextStyle?.blinking ?? false) line = line.blinking();
      if (titleTextStyle?.inverse ?? false) line = line.inverse();
      if (titleTextStyle?.invisible ?? false) line = line.invisible();
      if (titleTextStyle?.strikethrough ?? false) line = line.strikethrough();

      buffer.write(line);

      final int padding = maxTitleCardWidth - titleLine.length + 1;
      const int previousDecorationWidth = 7;
      final int remainingWidth =
          width - maxTitleCardWidth - previousDecorationWidth;

      if (isFirstLine && shouldSplitText) {
        buffer.write(
          (' ' * padding).colorBackground(title.style.backgroundColor),
        );
        buffer.write(rightConnector.colorForeground(title.style.borderColor));

        buffer.write(
          ((style.edgeStyle.x) * remainingWidth)
              .colorForeground(style.borderColor),
        );
        buffer.write(style.cornerStyle.tr.colorForeground(style.borderColor));
      }

      if (!isFirstLine && shouldSplitText) {
        buffer.write(
          (' ' * padding).colorBackground(title.style.backgroundColor),
        );
        buffer.write(
          title.style.edgeStyle.y.colorForeground(title.style.borderColor),
        );
        buffer.write(
          (' ' * remainingWidth).colorBackground(style.backgroundColor),
        );
        buffer
            .write(title.style.edgeStyle.y.colorForeground(style.borderColor));
      }

      if (!isLastLine && shouldSplitText) {
        buffer.writeln();

        buffer.write((' ' * panelPadding).colorBackground(backgroundColor));
        buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));

        buffer.write(
          ' '.colorBackground(style.backgroundColor),
        );
        buffer.write(
          title.style.edgeStyle.y.colorForeground(title.style.borderColor),
        );
        buffer.write(' '.colorBackground(title.style.backgroundColor));
      }

      if (isFirstLine && !shouldSplitText) {
        buffer.write(
          (' ' * padding).colorBackground(title.style.backgroundColor),
        );
        buffer.write(
          title.style.edgeStyle.y.colorForeground(title.style.borderColor),
        );
        buffer.write(
          (style.edgeStyle.x * remainingWidth)
              .colorForeground(style.borderColor),
        );
        buffer.write(style.cornerStyle.tr.colorForeground(style.borderColor));
      }

      buffer.write(
        (' ' * remainingSpace).colorBackground(backgroundColor),
      );
    }

    buffer.writeln();

    // Title's bottom border
    buffer.write((' ' * panelPadding).colorBackground(backgroundColor));
    buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));
    buffer.write(
      ' '.colorBackground(style.backgroundColor),
    );
    buffer.write(
      title.style.cornerStyle.bl.colorForeground(title.style.borderColor),
    );
    buffer.write(
      (title.style.edgeStyle.x * (maxTitleCardWidth + 2))
          .colorForeground(title.style.borderColor),
    );
    buffer.write(
      title.style.cornerStyle.br.colorForeground(title.style.borderColor),
    );
    buffer.write(
      (' ' * (width - maxTitleCardWidth - 7))
          .colorBackground(style.backgroundColor),
    );
    buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));
    buffer.write(
      (' ' * remainingSpace).colorBackground(backgroundColor),
    );
    buffer.writeln();
  }

  void _renderNoTitle(
    StringBuffer buffer,
    int finalWidth, {
    AnsiColor? backgroundColor,
  }) {
    buffer.write(style.cornerStyle.tl.colorForeground(style.borderColor));
    buffer.write(
      (style.edgeStyle.x * (finalWidth - 2)).colorForeground(style.borderColor),
    );
    buffer.write(style.cornerStyle.tr.colorForeground(style.borderColor));
    buffer.writeln();
  }

  void _renderBodyText(
    StringBuffer buffer,
    int charactersPerLine,
    int givenWidth,
    int finalWidth,
    int panelPadding, {
    required bool isChild,
    ChubbyPanelStyle? parentTheme,
    int parentPadding = 0,
    AnsiColor? backgroundColor,
  }) {
    assert(isChild == (parentTheme != null));

    final int numberOfLines =
        _calculateNumberOfLines(finalWidth, charactersPerLine, text);

    final List<String> bodyText = [];
    if (numberOfLines > 1) {
      bodyText.addAll(_splitString(text, charactersPerLine));
    } else {
      bodyText.add(text);
    }

    if (isChild) {
      buffer.write(' ' * parentPadding);
      buffer.write(
        parentTheme!.edgeStyle.y.colorForeground(parentTheme.borderColor),
      );
      buffer.write(' '.colorBackground(parentTheme.backgroundColor));
    }

    for (final String textLine in bodyText) {
      buffer.write((' ' * panelPadding).colorBackground(backgroundColor));
      buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));
      buffer.write(' '.colorBackground(style.backgroundColor));

      String line = textLine
          .alignText(
            width: charactersPerLine,
            alignment: style.textStyle?.alignment ?? TextAlignment.left,
          )
          .colorForeground(style.textStyle?.color)
          .colorBackground(style.backgroundColor);

      if (style.textStyle?.bold ?? false) line = line.bold();
      if (style.textStyle?.dim ?? false) line = line.dim();
      if (style.textStyle?.italic ?? false) line = line.italic();
      if (style.textStyle?.underline ?? false) line = line.underline();
      if (style.textStyle?.blinking ?? false) line = line.blinking();
      if (style.textStyle?.inverse ?? false) line = line.inverse();
      if (style.textStyle?.invisible ?? false) line = line.invisible();
      if (style.textStyle?.strikethrough ?? false) line = line.strikethrough();

      buffer.write(line);

      buffer.write(' '.colorBackground(style.backgroundColor));
      buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));

      final int remainingSpace = finalWidth - givenWidth - panelPadding;
      buffer.write((' ' * remainingSpace).colorBackground(backgroundColor));
      if (isChild) {
        buffer.write(
          (' ' * (finalWidth - parentPadding - panelPadding))
              .colorBackground(parentTheme!.backgroundColor),
        );
        buffer.write(
          parentTheme.edgeStyle.y.colorForeground(parentTheme.borderColor),
        );
      }

      buffer.writeln();
    }
  }

  void _renderPanelFooter(
    StringBuffer buffer,
    int panelPadding,
    int finalWidth,
  ) {
    buffer.write(' ' * panelPadding);

    buffer.write(style.cornerStyle.bl.colorForeground(style.borderColor));
    buffer.write(
      (style.edgeStyle.x * (finalWidth - 2)).colorForeground(style.borderColor),
    );
    buffer.write(style.cornerStyle.br.colorForeground(style.borderColor));
    buffer.writeln();
  }

  void _renderChild(
    StringBuffer buffer,
    int panelPadding,
    int parentWidth,
    ChubbyPanelStyle parentTheme,
    ChubbyWidget? child,
  ) {
    if (child == null) return;
    buffer.write(' ' * panelPadding);
    buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));
    buffer.write(' '.colorBackground(style.backgroundColor));

    child.render(
      buffer,
      parentWidth - (child.text?.length ?? 0) - 8,
      isChild: true,
      parentTheme: parentTheme,
      parentPadding: panelPadding,
    );
  }

  @override
  void render(
    StringBuffer buffer,
    int consoleWidth, {
    bool isChild = false,
    ChubbyPanelStyle parentTheme = const ChubbyPanelStyle(),
    int parentPadding = 0,
    AnsiColor? backgroundColor,
  }) {
    final int finalWidth = width ?? consoleWidth;
    final int charactersPerLine = _calculateCharactersPerLine(finalWidth, text);

    int panelPadding = 0;

    switch (alignment) {
      case TextAlignment.left:
        break;
      case TextAlignment.center:
        panelPadding = ((consoleWidth - finalWidth) / 2).ceil();
        break;
      case TextAlignment.right:
        panelPadding = consoleWidth - finalWidth;
        break;
    }

    buffer.write((' ' * panelPadding).colorBackground(backgroundColor));

    if (title != null) {
      _renderTitle(
        buffer,
        style,
        title!,
        finalWidth,
        consoleWidth,
        panelPadding,
        backgroundColor: backgroundColor,
      );
    }

    if (title == null) {
      _renderNoTitle(buffer, finalWidth, backgroundColor: backgroundColor);
    }

    _renderBodyText(
      buffer,
      charactersPerLine,
      finalWidth,
      consoleWidth,
      panelPadding,
      isChild: isChild,
      parentTheme: parentTheme,
      parentPadding: parentPadding,
      backgroundColor: backgroundColor,
    );
    if (isChild) {
      buffer.write(' ' * (panelPadding + parentPadding));
      buffer.write(
        parentTheme.edgeStyle.y.colorForeground(parentTheme.borderColor),
      );
      buffer.write(' ');
    }
    _renderChild(
      buffer,
      panelPadding,
      finalWidth - 4,
      parentTheme,
      child,
    );
    _renderPanelFooter(buffer, panelPadding, finalWidth);
  }

  int _calculateNumberOfLines(int width, int charactersPerLine, String text) {
    if ((text.length % width).ceil() > width) return 1;
    return (text.length / width).ceil();
  }

  int _calculateCharactersPerLine(int width, String text) {
    int charactersPerLine = width - 4;

    if (charactersPerLine > stdout.terminalColumns + 4) {
      charactersPerLine = stdout.terminalColumns - 4;
    }

    return charactersPerLine;
  }

  List<String> _splitString(String text, int charactersPerLine) {
    final List<String> result = [];
    final List<String> words = text.split(' ');

    while (result.join(' ') != text) {
      final StringBuffer buffer = StringBuffer();
      final List<String> processedWords = [];
      final String line = words
          .takeWhile((word) {
            final int wordCount = words.length;
            final int indexOfWord = words.indexOf(word) + 1;
            String nextWord = '';

            if (indexOfWord > wordCount) {
              nextWord = words[indexOfWord + 1];
            }

            if ((buffer.length + word.length + nextWord.length) <=
                charactersPerLine) {
              buffer.write('$word ');
              processedWords.add(word);
              return true;
            }
            return false;
          })
          .join(' ')
          .trim();
      for (final String word in processedWords) {
        words.remove(word);
      }
      processedWords.clear();
      result.add(line);
      buffer.clear();
    }
    return result;
  }
}
