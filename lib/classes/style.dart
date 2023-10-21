enum CornerStyle {
  doubled('╔', '╗', '╚', '╝'),
  round('╭', '╮', '╰', '╯'),
  square('┌', '┐', '└', '┘');

  final String tl;
  final String tr;
  final String bl;
  final String br;
  const CornerStyle(this.tl, this.tr, this.bl, this.br);
}

enum LineStyle {
  doubled('═', '║', '╣', '╢', '╠', '╟'),
  single('─', '│', '┤', '╡', '├', '╞');

  final String x;
  final String y;
  final String vl;
  final String vr;
  final String ovl;
  final String ovr;

  const LineStyle(
    this.x,
    this.y,
    this.vl,
    this.ovl,
    this.vr,
    this.ovr,
  );
}
