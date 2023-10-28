/// Decorate the corners of your panel.
///
/// Options include:
///
/// `CornerStyle.double`:
///
///         ╔════╗
///         ╚════╝
///
///
/// `CornerStyle.round`:
///
///         ╭────╮
///         ╰────╯
///
///
/// `CornerStyle.square`:
///
///         ┌────┐
///         └────┘
///
///
/// Combine with `EdgeStyle` for additional effects.
///
/// For example, a panel with `EdgeStyle.double` and `CornerStyle.round`
/// would produce a panel with the left side looking like this:
///
///         ╭══
///         ║
///         ╰══
///
///
enum CornerStyle {
  double('╔', '╗', '╚', '╝'),
  none(' ', ' ', ' ', ' '),
  round('╭', '╮', '╰', '╯'),
  square('┌', '┐', '└', '┘'),
  ;

  final String tl;
  final String tr;
  final String bl;
  final String br;
  const CornerStyle(this.tl, this.tr, this.bl, this.br);
}
