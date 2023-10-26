import 'dart:io';

import 'package:chubby_bubble/common/ansi.dart';
import 'package:chubby_bubble/features/panel/classes/edge_style.dart';
import 'package:chubby_bubble/features/panel/classes/panel_style.dart';
import 'package:chubby_bubble/features/panel/classes/panel_title.dart';
import 'package:dart_console/dart_console.dart';

export 'classes/corner_style.dart' show CornerStyle;
export 'classes/edge_style.dart' show EdgeStyle;
export 'classes/panel_style.dart' show ChubbyPanelStyle;
export 'classes/panel_title.dart' show ChubbyPanelTitle;

class ChubbyPanel {
  final ChubbyPanelStyle style;
  final ChubbyPanelTitle? title;
  final String text;
  final int? width;
  final TextAlignment alignment;
  final AnsiColor color;

  const ChubbyPanel(
    this.text, {
    this.style = const ChubbyPanelStyle(),
    this.title,
    this.width,
    this.alignment = TextAlignment.left,
    this.color = AnsiColor.brightWhite,
  });

  static final StringBuffer _buffer = StringBuffer();

  void _renderTitle(ChubbyPanelStyle style, ChubbyPanelTitle title, int width) {
    String leftConnector = title.style.edgeStyle.vl;
    String rightConnector = title.style.edgeStyle.vr;

    if (style.edgeStyle != EdgeStyle.double &&
        title.style.edgeStyle == EdgeStyle.double) {
      leftConnector = title.style.edgeStyle.ovl;
      rightConnector = title.style.edgeStyle.ovr;
    }

    final List<String> titleText = [title.text];

    // Calculate width of title card
    final int maxTitleCardWidth = ((width * 0.8) - 8).floor();
    final int titleTextLength = title.text.length;
    final bool shouldSplitText = titleTextLength > maxTitleCardWidth;

    if (shouldSplitText) {
      titleText.clear();
      titleText.addAll(_splitString(title.text, maxTitleCardWidth));
    }

    // Title's top border
    _buffer.write('  ');
    _buffer.write(
        title.style.cornerStyle.tl.colorForeground(title.style.borderColor));
    _buffer.write((title.style.edgeStyle.x * (maxTitleCardWidth + 2))
        .colorForeground(title.style.borderColor));
    _buffer.write(
        title.style.cornerStyle.tr.colorForeground(title.style.borderColor));
    _buffer.writeln();

    // Title content
    for (final String titleLine in titleText) {
      if (titleText.first == titleLine) {
        _buffer.write(style.cornerStyle.tl.colorForeground(style.borderColor));
        _buffer.write(style.edgeStyle.x.colorForeground(style.borderColor));
      }

      if (titleText.first == titleLine && shouldSplitText) {
        _buffer.write(leftConnector.colorForeground(style.borderColor));
        _buffer.write(' '.colorBackground(title.style.backgroundColor));
      }

      _buffer.write(
        titleLine
            .colorForeground(title.style.textColor)
            .padLeft(1)
            .padRight(1)
            .colorBackground(title.style.backgroundColor),
      );

      final int padding = maxTitleCardWidth - titleLine.length + 1;
      const int previousDecorationWidth = 7;
      final int remainingWidth =
          width - maxTitleCardWidth - previousDecorationWidth;

      if (titleText.first == titleLine && shouldSplitText) {
        _buffer.write(
            (' ' * padding).colorBackground(title.style.backgroundColor));
        _buffer.write(rightConnector.colorForeground(title.style.borderColor));
        _buffer.write(
          ((style.edgeStyle.x) * remainingWidth)
              .colorForeground(style.borderColor),
        );
        _buffer.write(style.cornerStyle.tr.colorForeground(style.borderColor));
      }

      if (titleText.first != titleLine && shouldSplitText) {
        _buffer.write(
            (' ' * padding).colorBackground(title.style.backgroundColor));
        _buffer.write(
            title.style.edgeStyle.y.colorForeground(title.style.borderColor));
        _buffer.write(
            (' ' * remainingWidth).colorBackground(style.backgroundColor));
        _buffer
            .write(title.style.edgeStyle.y.colorForeground(style.borderColor));
      }

      if (titleText.last != titleLine) {
        _buffer.writeln();
        _buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));
        _buffer.write(' '.colorBackground(style.backgroundColor));
        _buffer.write(
            title.style.edgeStyle.y.colorForeground(title.style.borderColor));
        _buffer.write(' '.colorBackground(title.style.backgroundColor));
      }
    }

    _buffer.writeln();

    // Title's bottom border
    _buffer.write(style.edgeStyle.y.colorForeground(style.borderColor));
    _buffer.write(' '.colorBackground(style.backgroundColor));
    _buffer.write(
        title.style.cornerStyle.bl.colorForeground(title.style.borderColor));
    _buffer.write((title.style.edgeStyle.x * (maxTitleCardWidth + 2))
        .colorForeground(title.style.borderColor));
    _buffer.write(
        title.style.cornerStyle.br.colorForeground(title.style.borderColor));
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
      _buffer.write(textLine
          .alignText(
            width: charactersPerLine,
            alignment: alignment,
          )
          .colorForeground(style.textColor)
          .colorBackground(style.backgroundColor));
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
