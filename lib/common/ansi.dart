enum AnsiCode {
  bold("\x1B[1m"),
  dim("\x1B[2m"),
  italic("\x1B[3m"),
  underline("\x1B[4m"),
  blinking("\x1B[5m"),
  inverse("\x1B[7m"),
  invisible("\x1B[8m"),
  strikethrough("\x1B[9m"),
  ;

  final String value;

  const AnsiCode(this.value);
}

// Set text colour to an RGB value: \x1b[38;2;255;255;0m -> 38;2;r;g;b
enum AnsiColor {
  black("\x1B[30m"),
  red("\x1B[31m"),
  green("\x1B[32m"),
  yellow("\x1B[33m"),
  blue("\x1B[34m"),
  magenta("\x1B[35m"),
  cyan("\x1B[36m"),
  white("\x1B[37m"),
  brightBlack("\x1B[90m"),
  brightRed("\x1B[91m"),
  brightGreen("\x1B[92m"),
  brightYellow("\x1B[93m"),
  brightBlue("\x1B[94m"),
  brightMagenta("\x1B[95m"),
  brightCyan("\x1B[96m"),
  brightWhite("\x1B[97m"),
  ;

  final String value;

  const AnsiColor(this.value);
}

enum AnsiReset {
  all("\x1B[0m"),
  bold("\x1B[22m"),
  dim("\x1B[22m"),
  italic("\x1B[23m"),
  underline("\x1B[24m"),
  blinking("\x1B[25m"),
  inverse("\x1B[27m"),
  invisible("\x1B[28m"),
  strikethrough("\x1B[29m"),
  ;

  final String value;

  const AnsiReset(this.value);
}

extension AnsiExtension on String {
  String blinking() {
    return AnsiCode.blinking.value + this + AnsiReset.blinking.value;
  }

  String bold() {
    return AnsiCode.bold.value + this + AnsiReset.bold.value;
  }

  String colorForeground(AnsiColor color) {
    return color.value + this + AnsiReset.all.value;
  }

  String colorBackground(AnsiColor color) {
    final List<String> splitCode = color.value.split('[');
    final int foregroundColor = int.parse(splitCode.last.replaceAll('m', ''));
    final int backgroundColor = foregroundColor + 10;
    final String backgroundColorCode = '${splitCode[0]}[${backgroundColor}m';

    return backgroundColorCode + this + AnsiReset.all.value;
  }

  String dim() {
    return AnsiCode.dim.value + this + AnsiReset.dim.value;
  }

  String inverse() {
    return AnsiCode.inverse.value + this + AnsiReset.inverse.value;
  }

  String invisible() {
    return AnsiCode.invisible.value + this + AnsiReset.invisible.value;
  }

  String italic() {
    return AnsiCode.italic.value + this + AnsiReset.italic.value;
  }

  String strikethrough() {
    return AnsiCode.strikethrough.value + this + AnsiReset.strikethrough.value;
  }

  String underline() {
    return AnsiCode.underline.value + this + AnsiReset.underline.value;
  }
}
