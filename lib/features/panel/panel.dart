import 'dart:io';

import 'package:chubby_bubble/common/ansi.dart';
import 'package:chubby_bubble/common/text_style.dart';
import 'package:chubby_bubble/features/panel/classes/edge_style.dart';
import 'package:chubby_bubble/features/panel/classes/panel_theme.dart';
import 'package:chubby_bubble/features/panel/classes/panel_title.dart';
import 'package:dart_console/dart_console.dart';

export 'classes/corner_style.dart' show CornerStyle;
export 'classes/edge_style.dart' show EdgeStyle;
export 'classes/panel_theme.dart' show ChubbyPanelTheme;
export 'classes/panel_title.dart' show ChubbyPanelTitle;

class ChubbyPanel {
  final ChubbyPanelTheme style;
  final ChubbyPanelTitle? title;
  final String text;
  final int? width;
  final TextAlignment alignment;
  final AnsiColor color;

  const ChubbyPanel(
    this.text, {
    this.style = const ChubbyPanelTheme(),
    this.title,
    this.width,
    this.alignment = TextAlignment.left,
    this.color = AnsiColor.brightWhite,
  });

  static final StringBuffer _buffer = StringBuffer();

  void _renderTitle(ChubbyPanelTheme style, ChubbyPanelTitle title, int width) {
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
    _buffer.write('  ');
    _buffer.write(
        title.theme.cornerStyle.tl.colorForeground(title.theme.borderColor));
    _buffer.write((title.theme.edgeStyle.x * (maxTitleCardWidth + 2))
        .colorForeground(title.theme.borderColor));
    _buffer.write(
        title.theme.cornerStyle.tr.colorForeground(title.theme.borderColor));
    _buffer.writeln();

    // Title content
    for (final String titleLine in titleText) {
      final int textIndex = titleText.indexOf(titleLine);
      final bool isFirstLine = textIndex == 0;
      final bool isLastLine = textIndex == titleText.length - 1;

      if (isFirstLine) {
        _buffer.write(style.cornerStyle.tl.colorForeground(style.borderColor));
        _buffer.write(style.edgeStyle.x.colorForeground(style.borderColor));
        _buffer.write(leftConnector.colorForeground(style.borderColor));
        _buffer.write(' '.colorBackground(title.theme.backgroundColor));
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

      _buffer.write(line);

      final int padding = maxTitleCardWidth - titleLine.length + 1;
      const int previousDecorationWidth = 7;
      final int remainingWidth =
          width - maxTitleCardWidth - previousDecorationWidth;

      if (isFirstLine && shouldSplitText) {
        _buffer.write(
            (' ' * padding).colorBackground(title.theme.backgroundColor));
        _buffer.write(rightConnector.colorForeground(title.theme.borderColor));
        _buffer.write(
          ((style.edgeStyle.x) * remainingWidth)
              .colorForeground(style.borderColor),
        );
        _buffer.write(style.cornerStyle.tr.colorForeground(style.borderColor));
      }

      if (!isFirstLine && shouldSplitText) {
        _buffer.write(
            (' ' * padding).colorBackground(title.theme.backgroundColor));
        _buffer.write(
            title.theme.edgeStyle.y.colorForeground(title.theme.borderColor));
        _buffer.write(
            (' ' * remainingWidth).colorBackground(style.backgroundColor));
        _buffer
            .write(title.theme.edgeStyle.y.colorForeground(style.borderColor));
      }

      if (!isLastLine && shouldSplitText) {
        _buffer.writeln();
        _buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));
        _buffer.write(' '.colorBackground(style.backgroundColor));
        _buffer.write(
            title.theme.edgeStyle.y.colorForeground(title.theme.borderColor));
        _buffer.write(' '.colorBackground(title.theme.backgroundColor));
      }

      if (isFirstLine && !shouldSplitText) {
        _buffer.write(
            (' ' * padding).colorBackground(title.theme.backgroundColor));
        _buffer.write(
            title.theme.edgeStyle.y.colorForeground(title.theme.borderColor));
        _buffer.write((style.edgeStyle.x * remainingWidth)
            .colorForeground(style.borderColor));
        _buffer.write(style.cornerStyle.tr.colorForeground(style.borderColor));
      }
    }

    _buffer.writeln();

    // Title's bottom border
    _buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));
    _buffer.write(' '.colorBackground(style.backgroundColor));
    _buffer.write(
        title.theme.cornerStyle.bl.colorForeground(title.theme.borderColor));
    _buffer.write((title.theme.edgeStyle.x * (maxTitleCardWidth + 2))
        .colorForeground(title.theme.borderColor));
    _buffer.write(
        title.theme.cornerStyle.br.colorForeground(title.theme.borderColor));
    _buffer.write((' ' * (width - maxTitleCardWidth - 7))
        .colorBackground(style.backgroundColor));
    _buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));
    _buffer.writeln();
  }

  void render(Console console) {
    final int finalWidth =
        _calculatePanelWidth(width ?? stdout.terminalColumns, text);
    final int charactersPerLine = _calculateCharactersPerLine(finalWidth, text);
    final int numberOfLines =
        _calculateNumberOfLines(finalWidth, charactersPerLine, text);

    if (title != null) {
      _renderTitle(style, title!, finalWidth);
    }

    if (title == null) {
      _buffer.write(style.cornerStyle.tl.colorForeground(style.borderColor));
      _buffer.write((style.edgeStyle.x * (finalWidth - 2))
          .colorForeground(style.borderColor));
      _buffer.write(style.cornerStyle.tr.colorForeground(style.borderColor));
      _buffer.writeln();
    }

    final List<String> bodyText = [];
    if (numberOfLines > 1) {
      bodyText.addAll(_splitString(text, charactersPerLine));
    } else {
      bodyText.add(text);
    }

    for (final String textLine in bodyText) {
      _buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));
      _buffer.write(' '.colorBackground(style.backgroundColor));

      String line = textLine
          .alignText(
            width: charactersPerLine,
            alignment: alignment,
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

      _buffer.write(line);

      _buffer.write(' '.colorBackground(style.backgroundColor));
      _buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));
      _buffer.writeln();
    }

    _buffer.write(style.cornerStyle.bl.colorForeground(style.borderColor));
    _buffer.write((style.edgeStyle.x * (finalWidth - 2))
        .colorForeground(style.borderColor));
    _buffer.write(style.cornerStyle.br.colorForeground(style.borderColor));
    _buffer.writeln();

    console.write(_buffer.toString());
    _buffer.clear();
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
    List<String> result = [];
    final List<String> words = text.split(' ');

    while (result.join(' ') != text) {
      StringBuffer buffer = StringBuffer();
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
