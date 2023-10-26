import 'dart:io';

import 'package:chubby_bubble/chubby_bubble.dart';
import 'package:chubby_bubble/common/widget.dart';
import 'package:dart_console/dart_console.dart';

export 'classes/corner_style.dart' show CornerStyle;
export 'classes/edge_style.dart' show EdgeStyle;
export 'classes/panel_theme.dart' show ChubbyPanelTheme;
export 'classes/panel_title.dart' show ChubbyPanelTitle;

class ChubbyPanel implements ChubbyWidget {
  final ChubbyPanelTheme theme;
  final ChubbyPanelTitle? title;
  final String text;
  final int? width;
  final TextAlignment alignment;
  final AnsiColor? color;
  final ChubbyWidget? child;

  const ChubbyPanel(
    this.text, {
    this.theme = const ChubbyPanelTheme(),
    this.title,
    this.width,
    this.alignment = TextAlignment.left,
    this.color = AnsiColor.brightWhite,
    this.child,
  });

  void _renderTitle(
    StringBuffer buffer,
    ChubbyPanelTheme style,
    ChubbyPanelTitle title,
    int width,
    int panelPadding,
  ) {
    final ChubbyTextStyle? titleTextStyle = title.theme.textStyle;
    String leftConnector = title.theme.edgeStyle.vl;
    String rightConnector = title.theme.edgeStyle.vr;

    if (style.edgeStyle != EdgeStyle.double &&
        title.theme.edgeStyle == EdgeStyle.double) {
      leftConnector = title.theme.edgeStyle.ovl;
      rightConnector = title.theme.edgeStyle.ovr;
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
    buffer.write('  ');
    buffer.write(
      title.theme.cornerStyle.tl.colorForeground(title.theme.borderColor),
    );
    buffer.write(
      (title.theme.edgeStyle.x * (maxTitleCardWidth + 2))
          .colorForeground(title.theme.borderColor),
    );
    buffer.write(
      title.theme.cornerStyle.tr.colorForeground(title.theme.borderColor),
    );
    buffer.writeln();

    // Title content
    for (final String titleLine in titleText) {
      final int textIndex = titleText.indexOf(titleLine);
      final bool isFirstLine = textIndex == 0;
      final bool isLastLine = textIndex == titleText.length - 1;

      if (isFirstLine) {
        buffer.write(' ' * panelPadding);
        buffer.write(style.cornerStyle.tl.colorForeground(style.borderColor));

        buffer.write(
          style.edgeStyle.x.colorForeground(style.borderColor),
        );
        buffer.write(leftConnector.colorForeground(style.borderColor));
        buffer.write(' '.colorBackground(title.theme.backgroundColor));
      }

      String line = titleLine
          .colorForeground(titleTextStyle?.color)
          .padLeft(1)
          .padRight(1)
          .colorBackground(title.theme.backgroundColor);

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
          (' ' * padding).colorBackground(title.theme.backgroundColor),
        );
        buffer.write(rightConnector.colorForeground(title.theme.borderColor));

        buffer.write(
          ((style.edgeStyle.x) * remainingWidth)
              .colorForeground(style.borderColor),
        );
        buffer.write(style.cornerStyle.tr.colorForeground(style.borderColor));
      }

      if (!isFirstLine && shouldSplitText) {
        buffer.write(
          (' ' * padding).colorBackground(title.theme.backgroundColor),
        );
        buffer.write(
          title.theme.edgeStyle.y.colorForeground(title.theme.borderColor),
        );
        buffer.write(
          (' ' * remainingWidth).colorBackground(style.backgroundColor),
        );
        buffer
            .write(title.theme.edgeStyle.y.colorForeground(style.borderColor));
      }

      if (!isLastLine && shouldSplitText) {
        buffer.writeln();

        buffer.write(' ' * panelPadding);
        buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));

        buffer.write(
          ' '.colorBackground(style.backgroundColor),
        );
        buffer.write(
          title.theme.edgeStyle.y.colorForeground(title.theme.borderColor),
        );
        buffer.write(' '.colorBackground(title.theme.backgroundColor));
      }

      if (isFirstLine && !shouldSplitText) {
        buffer.write(
          (' ' * padding).colorBackground(title.theme.backgroundColor),
        );
        buffer.write(
          title.theme.edgeStyle.y.colorForeground(title.theme.borderColor),
        );
        buffer.write(
          (style.edgeStyle.x * remainingWidth)
              .colorForeground(style.borderColor),
        );
        buffer.write(style.cornerStyle.tr.colorForeground(style.borderColor));
      }
    }
    buffer.writeln();

    // Title's bottom border
    buffer.write(' ' * panelPadding);
    buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));
    buffer.write(
      ' '.colorBackground(style.backgroundColor),
    );
    buffer.write(
      title.theme.cornerStyle.bl.colorForeground(title.theme.borderColor),
    );
    buffer.write(
      (title.theme.edgeStyle.x * (maxTitleCardWidth + 2))
          .colorForeground(title.theme.borderColor),
    );
    buffer.write(
      title.theme.cornerStyle.br.colorForeground(title.theme.borderColor),
    );
    buffer.write(
      (' ' * (width - maxTitleCardWidth - 7))
          .colorBackground(style.backgroundColor),
    );
    buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));
    buffer.writeln();
  }

  void _renderNoTitle(StringBuffer buffer, int finalWidth) {
    buffer.write(theme.cornerStyle.tl.colorForeground(theme.borderColor));
    buffer.write(
      (theme.edgeStyle.x * (finalWidth - 2)).colorForeground(theme.borderColor),
    );
    buffer.write(theme.cornerStyle.tr.colorForeground(theme.borderColor));
    buffer.writeln();
  }

  void _renderBodyText(
    StringBuffer buffer,
    int givenWidth,
    int finalWidth,
    int panelPadding,
  ) {
    final int charactersPerLine = _calculateCharactersPerLine(finalWidth, text);
    final int numberOfLines =
        _calculateNumberOfLines(finalWidth, charactersPerLine, text);

    final List<String> bodyText = [];
    if (numberOfLines > 1) {
      bodyText.addAll(_splitString(text, charactersPerLine));
    } else {
      bodyText.add(text);
    }

    for (final String textLine in bodyText) {
      buffer.write(' ' * panelPadding);
      buffer.write(theme.edgeStyle.y.colorForeground(theme.borderColor));
      buffer.write(' '.colorBackground(theme.backgroundColor));

      String line = textLine
          .alignText(
            width: charactersPerLine,
            alignment: theme.textStyle?.alignment ?? TextAlignment.left,
          )
          .colorForeground(theme.textStyle?.color)
          .colorBackground(theme.backgroundColor);

      if (theme.textStyle?.bold ?? false) line = line.bold();
      if (theme.textStyle?.dim ?? false) line = line.dim();
      if (theme.textStyle?.italic ?? false) line = line.italic();
      if (theme.textStyle?.underline ?? false) line = line.underline();
      if (theme.textStyle?.blinking ?? false) line = line.blinking();
      if (theme.textStyle?.inverse ?? false) line = line.inverse();
      if (theme.textStyle?.invisible ?? false) line = line.invisible();
      if (theme.textStyle?.strikethrough ?? false) line = line.strikethrough();

      buffer.write(line);

      buffer.write(' '.colorBackground(theme.backgroundColor));
      buffer.write(theme.edgeStyle.y.colorForeground(theme.borderColor));
      buffer.writeln();
    }
  }

  void _renderPanelFooter(
    StringBuffer buffer,
    int panelPadding,
    int finalWidth,
  ) {
    buffer.write(' ' * panelPadding);

    buffer.write(theme.cornerStyle.bl.colorForeground(theme.borderColor));
    buffer.write(
      (theme.edgeStyle.x * (finalWidth - 2)).colorForeground(theme.borderColor),
    );
    buffer.write(theme.cornerStyle.br.colorForeground(theme.borderColor));
    buffer.writeln();
  }

  void _renderChild(
    StringBuffer buffer,
    int panelPadding,
    ChubbyWidget? child,
  ) {
    if (child == null) return;
    buffer.write(' ' * panelPadding);
    // FIXME: Why are you broken?
    child.render(buffer);
    buffer.writeln();
  }

  @override
  void render(StringBuffer buffer) {
    final int givenWidth = width ?? stdout.terminalColumns;
    final int finalWidth = _calculatePanelWidth(givenWidth, text);

    int panelPadding = 0;

    switch (alignment) {
      case TextAlignment.left:
        break;
      case TextAlignment.center:
        panelPadding = ((givenWidth - finalWidth) / 2).floor();
        break;
      case TextAlignment.right:
        panelPadding = givenWidth - finalWidth;
        break;
    }

    buffer.write(' ' * panelPadding);

    if (title != null) {
      _renderTitle(
        buffer,
        theme,
        title!,
        finalWidth,
        panelPadding,
      );
    }

    if (title == null) {
      _renderNoTitle(buffer, finalWidth);
    }

    _renderBodyText(buffer, givenWidth, finalWidth, panelPadding);
    _renderChild(buffer, panelPadding, ChubbyPanel('Hello', width: finalWidth));
    _renderPanelFooter(buffer, panelPadding, finalWidth);
  }

  int _calculateNumberOfLines(int width, int charactersPerLine, String text) {
    if ((text.length % width).ceil() > width) return 1;
    return (text.length / width).ceil();
  }

  int _calculatePanelWidth(int width, String text) {
    final int consoleWidthIncludingPanel = stdout.terminalColumns - 4;

    int calculatedWidth = consoleWidthIncludingPanel;

    calculatedWidth = width;
    if (consoleWidthIncludingPanel < width) {
      calculatedWidth = consoleWidthIncludingPanel;
    }

    return calculatedWidth;
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
