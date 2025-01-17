enum SpinnerStyle {
  line(
    frames: ["|", "/", "-", "\\"],
    fps: Duration(milliseconds: 100),
  ),
  dot(
    frames: ["⣾ ", "⣽ ", "⣻ ", "⢿ ", "⡿ ", "⣟ ", "⣯ ", "⣷ "],
    fps: Duration(milliseconds: 100),
  ),
  miniDot(
    frames: ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"],
    fps: Duration(milliseconds: 83),
  ),
  jump(
    frames: ["⢄", "⢂", "⢁", "⡁", "⡈", "⡐", "⡠"],
    fps: Duration(milliseconds: 100),
  ),
  pulse(
    frames: ["█", "▓", "▒", "░"],
    fps: Duration(milliseconds: 125),
  ),
  points(
    frames: ["∙∙∙", "●∙∙", "∙●∙", "∙∙●"],
    fps: Duration(milliseconds: 143),
  ),
  globe(
    frames: ["🌍", "🌎", "🌏"],
    fps: Duration(milliseconds: 250),
  ),
  moon(
    frames: ["🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘"],
    fps: Duration(milliseconds: 125),
  ),
  monkey(
    frames: ["🙈", "🙉", "🙊"],
    fps: Duration(milliseconds: 333),
  ),
  meter(
    frames: ["▱▱▱", "▰▱▱", "▰▰▱", "▰▰▰", "▰▰▱", "▰▱▱", "▱▱▱"],
    fps: Duration(milliseconds: 143),
  ),
  hamburger(
    frames: ["☱", "☲", "☴", "☲"],
    fps: Duration(milliseconds: 333),
  ),
  ellipsis(
    frames: ["", ".", "..", "..."],
    fps: Duration(milliseconds: 333),
  ),
  ;

  final List<String> frames;
  final Duration fps;

  const SpinnerStyle({
    required this.frames,
    required this.fps,
  });
}
