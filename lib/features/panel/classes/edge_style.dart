/// Decorate the edges of your panel.
///
/// Options include:
///
/// `EdgeStyle.double`:
///
///         ╔════╗
///         ╚════╝
///
///
/// `EdgeStyle.single`:
///
///         ┌────┐
///         └────┘
///
///
/// Combine with `CornerStyle` for additional effects.
///
/// For example, a panel with `EdgeStyle.double` and `CornerStyle.round`
/// would produce a panel with the left side looking like this:
///
///         ╭══
///         ║
///         ╰══
///
/// Individual glyphs are as follows:
///
/// - `x`: The horizontal (x-axis) line segment.
///   - `EdgeStyle.single`: ─
///   - `EdgeStyle.double`: ═
/// - `y`: The vertical (y-axis) line segment.
///   - `EdgeStyle.single`: │
///   - `EdgeStyle.double`: ║
/// - `vl`: This segment is used when connecting an `EdgeStyle` horizontal line of the *same style* (double or single) from the _left_ to a vertical line on the _right_.
///   - `EdgeStyle.single`: ╣
///   - `EdgeStyle.double`: ┤
/// - `vr`: This segment is used when connecting an `EdgeStyle` horizontal line of the *same style* (double or single) from the _right_ to a vertical line on the _left_.
///   - `EdgeStyle.single`: ╠
///   - `EdgeStyle.double`: ├
/// - `ovl`: This segment is used when connecting an `EdgeStyle` horizontal line of the *opposite style* (double or single) from the _left_ to a vertical line on the _right_.
///   - `EdgeStyle.single`: ╢
///   - `EdgeStyle.double`: ╡
/// - `ovr`: This segment is used when connecting an `EdgeStyle` horizontal line of the *opposite style* (double or single) from the _right_ to a vertical line on the _left_.
///   - `EdgeStyle.single`: ╟
///   - `EdgeStyle.double`: ╞
enum EdgeStyle {
  /// A double-line-thick edge style.
  ///
  /// When combined with `CornerStyle.double`:
  ///
  ///         ╔════╗
  ///         ╚════╝
  ///
  ///  - x: ═
  /// - y: ║
  /// - vl: ╣
  /// - ovl: ╢
  /// - vr: ╠
  /// - ovr: ╟
  double('═', '║', '╣', '╢', '╠', '╟'),

  /// A single-line-thick edge style.
  ///
  /// When combined with `CornerStyle.square`:
  ///
  ///         ┌────┐
  ///         └────┘
  ///
  ///  - x: ─
  /// - y: │
  /// - vl: ┤
  /// - ovl: ╡
  /// - vr: ├
  /// - ovr: ╞
  single('─', '│', '┤', '╡', '├', '╞'),
  none(' ', ' ', ' ', ' ', ' ', ' '),
  ;

  /// The horizontal (x-axis) line segment.
  final String x;

  /// The vertical (y-axis) line segment.
  final String y;

  /// This segment is used when connecting an `EdgeStyle` horizontal line of the *same style* (double or single) from the _left_ to a vertical line on the _right_.
  final String vl;

  /// This segment is used when connecting an `EdgeStyle` horizontal line of the *same style* (double or single) from the _right_ to a vertical line on the _left_.
  final String vr;

  /// This segment is used when connecting an `EdgeStyle` horizontal line of the *opposite style* (double or single) from the _left_ to a vertical line on the _right_.
  final String ovl;

  /// This segment is used when connecting an `EdgeStyle` horizontal line of the *opposite style* (double or single) from the _right_ to a vertical line on the _left_.
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
