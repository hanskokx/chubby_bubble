import 'dart:async';

import 'package:chubby_bubble/common/ansi.dart';
import 'package:chubby_bubble/features/spinner/styles/spinner_styles.dart';
import 'package:dart_console/dart_console.dart';

class Spinner {
  final SpinnerStyle? style;

  const Spinner({this.style});

  static final StringBuffer _buffer = StringBuffer();

  void render(Console console) {
    final spinnerStyle = style ?? SpinnerStyle.dot;

    Timer.periodic(spinnerStyle.fps, (Timer tick) {
      final List<String> frames = spinnerStyle.frames;

      final int current = (tick.tick - 1) % spinnerStyle.frames.length;

      final int longestFrameInSequence = spinnerStyle.frames
          .reduce(
            (String a, String b) => a.length > b.length ? a : b,
          )
          .length;

      final int previous =
          ((tick.tick - 2) % spinnerStyle.frames.length).clamp(0, longestFrameInSequence);

      _buffer.clear();

      _buffer.write(
        (AnsiReset.line.value * frames[previous].length) + AnsiReset.line.value,
      );

      _buffer.write(" " * longestFrameInSequence);
      _buffer.write(AnsiReset.line.value * longestFrameInSequence);

      _buffer.write(spinnerStyle.frames[current]);

      console.write(_buffer);
    });
  }
}
