import 'package:chubby_bubble/chubby_bubble.dart';
import 'package:chubby_bubble/features/spinner/styles/spinner_styles.dart';

int main(List<String> arguments) {
  // Panel with title
  // ChubbyBubble.panel(
  //   'Left align panel with rounded corners and a title with rounded corners',
  //   alignment: TextAlignment.left,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //     textStyle: ChubbyTextStyle(),
  //   ),
  //   title: const ChubbyPanelTitle(
  //     "ChubbyBubble",
  //     theme: ChubbyPanelTheme(
  //       cornerStyle: CornerStyle.round,
  //     ),
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Left align panel with square corners and a title with doubled corners',
  //   alignment: TextAlignment.left,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.square,
  //   ),
  //   title: const ChubbyPanelTitle(
  //     "ChubbyBubble",
  //     theme: ChubbyPanelTheme(
  //       cornerStyle: CornerStyle.double,
  //     ),
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Left align panel with doubled corners and a title with square corners',
  //   alignment: TextAlignment.left,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.double,
  //   ),
  //   title: const ChubbyPanelTitle(
  //     "ChubbyPanel",
  //     theme: ChubbyPanelTheme(
  //       cornerStyle: CornerStyle.square,
  //     ),
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Left align panel with doubled edges and corners and a title with round corners',
  //   alignment: TextAlignment.left,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.double,
  //     edgeStyle: EdgeStyle.double,
  //   ),
  //   title: const ChubbyPanelTitle(
  //     "ChubbyPanel",
  //     theme: ChubbyPanelTheme(
  //       cornerStyle: CornerStyle.round,
  //     ),
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Left align panel with round corners and a title with doubled corners',
  //   alignment: TextAlignment.left,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  //   title: const ChubbyPanelTitle(
  //     "ChubbyPanel",
  //     theme: ChubbyPanelTheme(
  //       cornerStyle: CornerStyle.double,
  //     ),
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Center align panel with rounded corners and a title with rounded corners',
  //   alignment: TextAlignment.center,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  //   title: const ChubbyPanelTitle(
  //     "ChubbyPanel",
  //     theme: ChubbyPanelTheme(
  //       cornerStyle: CornerStyle.round,
  //     ),
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Right align panel with rounded corners and a title with rounded corners',
  //   alignment: TextAlignment.right,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  //   title: const ChubbyPanelTitle(
  //     "ChubbyPanel",
  //     theme: ChubbyPanelTheme(
  //       cornerStyle: CornerStyle.round,
  //     ),
  //   ),
  // );

  // // ChubbyPanel with no title
  // ChubbyBubble.panel(
  //   'Left align panel with rounded corners and no title',
  //   alignment: TextAlignment.left,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Center align panel with rounded corners and no title',
  //   alignment: TextAlignment.center,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Right align panel with rounded corners and no title',
  //   alignment: TextAlignment.right,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  // );

  // // ChubbyPanel with title and 80 width
  // ChubbyBubble.panel(
  //   'Left align panel with rounded corners and a title with rounded corners at 80 col width',
  //   alignment: TextAlignment.left,
  //   width: 80,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  //   title: const ChubbyPanelTitle(
  //     "ChubbyPanel",
  //     theme: ChubbyPanelTheme(
  //       cornerStyle: CornerStyle.round,
  //     ),
  //   ),
  // );

  // // ChubbyPanel with title and max width
  // ChubbyBubble.panel(
  //   'Left align panel with rounded corners and a title with rounded corners at maximum width',
  //   alignment: TextAlignment.left,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  //   title: const ChubbyPanelTitle(
  //     "ChubbyPanel",
  //     theme: ChubbyPanelTheme(
  //       cornerStyle: CornerStyle.round,
  //     ),
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Center align panel with rounded corners and a title with rounded corners at maximum width',
  //   alignment: TextAlignment.center,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  //   title: const ChubbyPanelTitle(
  //     "ChubbyPanel",
  //     theme: ChubbyPanelTheme(
  //       cornerStyle: CornerStyle.round,
  //     ),
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Right align panel with rounded corners and a title with rounded corners at maximum width',
  //   alignment: TextAlignment.right,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  //   title: const ChubbyPanelTitle(
  //     "ChubbyPanel",
  //     theme: ChubbyPanelTheme(
  //       cornerStyle: CornerStyle.round,
  //     ),
  //   ),
  // );

  // // ChubbyPanel with no title and max width
  // ChubbyBubble.panel(
  //   'Left align panel with rounded corners and no title, bright green text and a bright red border',
  //   alignment: TextAlignment.left,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //     borderColor: AnsiColor.brightRed,
  //     textStyle: ChubbyTextStyle(
  //       color: AnsiColor.brightGreen,
  //     ),
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Center align panel with rounded corners and no title',
  //   alignment: TextAlignment.center,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Right align panel with rounded corners and no title',
  //   alignment: TextAlignment.right,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Takimata no consectetuer dolor iriure dolore. Takimata sea luptatum euismod dolor eu dolore eirmod tation nonumy aliquyam. Ipsum eirmod erat tempor sadipscing ipsum dolore et sed sea diam stet aliquyam possim eleifend no gubergren. Rebum gubergren mazim dolore et commodo magna ipsum rebum luptatum blandit et. Ut clita diam suscipit dolor erat dolore hendrerit sadipscing nostrud erat et lorem magna sit rebum. Dolore ipsum diam dolor no sed feugiat et takimata dolore lorem sed tation sit dignissim clita. Et amet nonumy ut gubergren sit lobortis dolores et amet rebum justo consetetur invidunt ut eirmod sed. Et eirmod sed amet labore sed nonumy molestie. Et lorem lobortis sadipscing suscipit stet ipsum ut dolor vero. Accusam ut nonumy ut esse sed dolores feugiat stet in rebum dolor dolores luptatum assum vero duo. Dolores nonummy quis in dolore ea ipsum dolores et ut ipsum invidunt eos et dolor invidunt augue rebum et. Vulputate sanctus gubergren. Erat gubergren at imperdiet eirmod exerci accusam dolor. Dolor ut sed nostrud.',
  //   alignment: TextAlignment.left,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  // );

  // ChubbyBubble.panel(
  //   'Takimata no consectetuer dolor iriure dolore. Takimata sea luptatum euismod dolor eu dolore eirmod tation nonumy aliquyam. Ipsum eirmod erat tempor sadipscing ipsum dolore et sed sea diam stet aliquyam possim eleifend no gubergren. Rebum gubergren mazim dolore et commodo magna ipsum rebum luptatum blandit et. Ut clita diam suscipit dolor erat dolore hendrerit sadipscing nostrud erat et lorem magna sit rebum. Dolore ipsum diam dolor no sed feugiat et takimata dolore lorem sed tation sit dignissim clita. Et amet nonumy ut gubergren sit lobortis dolores et amet rebum justo consetetur invidunt ut eirmod sed. Et eirmod sed amet labore sed nonumy molestie. Et lorem lobortis sadipscing suscipit stet ipsum ut dolor vero. Accusam ut nonumy ut esse sed dolores feugiat stet in rebum dolor dolores luptatum assum vero duo. Dolores nonummy quis in dolore ea ipsum dolores et ut ipsum invidunt eos et dolor invidunt augue rebum et. Vulputate sanctus gubergren. Erat gubergren at imperdiet eirmod exerci accusam dolor. Dolor ut sed nostrud.',
  //   width: 80,
  //   alignment: TextAlignment.center,
  //   theme: const ChubbyPanelTheme(
  //     cornerStyle: CornerStyle.round,
  //   ),
  //   title: const ChubbyPanelTitle(
  //     'Hello',
  //   ),
  // );

  ChubbyBubble.spinner(style: SpinnerStyle.meter);

  return 0;
}
