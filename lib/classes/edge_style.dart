enum EdgeStyle {
  double('═', '║', '╣', '╢', '╠', '╟'),
  single('─', '│', '┤', '╡', '├', '╞');

  final String x;
  final String y;
  final String vl;
  final String vr;
  final String ovl;
  final String ovr;

  const EdgeStyle(
    this.x,
    this.y,
    this.vl,
    this.ovl,
    this.vr,
    this.ovr,
  );
}
