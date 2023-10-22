import 'package:chubby_bubble/chubby_bubble.dart';

main(List<String> arguments) {
  // Panel with title
  ChubbyBubble.panel(
    'Left align panel with rounded corners and a title with rounded corners',
    alignment: TextAlignment.left,
    style: CornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: CornerStyle.round,
    ),
  );

  ChubbyBubble.panel(
    'Left align panel with square corners and a title with doubled corners',
    alignment: TextAlignment.left,
    style: CornerStyle.square,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: CornerStyle.doubled,
    ),
  );

  ChubbyBubble.panel(
    'Left align panel with doubled corners and a title with square corners',
    alignment: TextAlignment.left,
    style: CornerStyle.doubled,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: CornerStyle.square,
    ),
  );

  ChubbyBubble.panel(
    'Left align panel with doubled corners and a title with round corners',
    alignment: TextAlignment.left,
    style: CornerStyle.doubled,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: CornerStyle.round,
    ),
  );

  ChubbyBubble.panel(
    'Left align panel with round corners and a title with doubled corners',
    alignment: TextAlignment.left,
    style: CornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: CornerStyle.doubled,
    ),
  );

  ChubbyBubble.panel(
    'Center align panel with rounded corners and a title with rounded corners',
    alignment: TextAlignment.center,
    style: CornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: CornerStyle.round,
    ),
  );

  ChubbyBubble.panel(
    'Right align panel with rounded corners and a title with rounded corners',
    alignment: TextAlignment.right,
    style: CornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: CornerStyle.round,
    ),
  );

  // ChubbyPanel with no title
  ChubbyBubble.panel(
    'Left align panel with rounded corners and no title',
    alignment: TextAlignment.left,
    style: CornerStyle.round,
  );

  ChubbyBubble.panel(
    'Center align panel with rounded corners and no title',
    alignment: TextAlignment.center,
    style: CornerStyle.round,
  );

  ChubbyBubble.panel(
    'Right align panel with rounded corners and no title',
    alignment: TextAlignment.right,
    style: CornerStyle.round,
  );

  // ChubbyPanel with title and 80 width
  ChubbyBubble.panel(
    'Left align panel with rounded corners and a title with rounded corners at 80 col width',
    alignment: TextAlignment.left,
    width: 80,
    style: CornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: CornerStyle.round,
    ),
  );

  // ChubbyPanel with title and max width
  ChubbyBubble.panel(
    'Left align panel with rounded corners and a title with rounded corners at maximum width',
    alignment: TextAlignment.left,
    width: 1000,
    style: CornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: CornerStyle.round,
    ),
  );

  ChubbyBubble.panel(
    'Center align panel with rounded corners and a title with rounded corners at maximum width',
    alignment: TextAlignment.center,
    width: 1000,
    style: CornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: CornerStyle.round,
    ),
  );

  ChubbyBubble.panel(
    'Right align panel with rounded corners and a title with rounded corners at maximum width',
    alignment: TextAlignment.right,
    width: 1000,
    style: CornerStyle.round,
    title: ChubbyPanelTitle(
      "ChubbyPanel",
      style: CornerStyle.round,
    ),
  );

  // ChubbyPanel with no title and max width
  ChubbyBubble.panel(
    'Left align panel with rounded corners and no title',
    width: 1000,
    alignment: TextAlignment.left,
    style: CornerStyle.round,
  );

  ChubbyBubble.panel(
    'Center align panel with rounded corners and no title',
    width: 1000,
    alignment: TextAlignment.center,
    style: CornerStyle.round,
  );

  ChubbyBubble.panel(
    'Right align panel with rounded corners and no title',
    width: 1000,
    alignment: TextAlignment.right,
    style: CornerStyle.round,
  );

  ChubbyBubble.panel(
    'Takimata no consectetuer dolor iriure dolore. Takimata sea luptatum euismod dolor eu dolore eirmod tation nonumy aliquyam. Ipsum eirmod erat tempor sadipscing ipsum dolore et sed sea diam stet aliquyam possim eleifend no gubergren. Rebum gubergren mazim dolore et commodo magna ipsum rebum luptatum blandit et. Ut clita diam suscipit dolor erat dolore hendrerit sadipscing nostrud erat et lorem magna sit rebum. Dolore ipsum diam dolor no sed feugiat et takimata dolore lorem sed tation sit dignissim clita. Et amet nonumy ut gubergren sit lobortis dolores et amet rebum justo consetetur invidunt ut eirmod sed. Et eirmod sed amet labore sed nonumy molestie. Et lorem lobortis sadipscing suscipit stet ipsum ut dolor vero. Accusam ut nonumy ut esse sed dolores feugiat stet in rebum dolor dolores luptatum assum vero duo. Dolores nonummy quis in dolore ea ipsum dolores et ut ipsum invidunt eos et dolor invidunt augue rebum et. Vulputate sanctus gubergren. Erat gubergren at imperdiet eirmod exerci accusam dolor. Dolor ut sed nostrud.',
    width: 1000,
    alignment: TextAlignment.left,
    style: CornerStyle.round,
  );

  ChubbyBubble.panel(
    'Takimata no consectetuer dolor iriure dolore. Takimata sea luptatum euismod dolor eu dolore eirmod tation nonumy aliquyam. Ipsum eirmod erat tempor sadipscing ipsum dolore et sed sea diam stet aliquyam possim eleifend no gubergren. Rebum gubergren mazim dolore et commodo magna ipsum rebum luptatum blandit et. Ut clita diam suscipit dolor erat dolore hendrerit sadipscing nostrud erat et lorem magna sit rebum. Dolore ipsum diam dolor no sed feugiat et takimata dolore lorem sed tation sit dignissim clita. Et amet nonumy ut gubergren sit lobortis dolores et amet rebum justo consetetur invidunt ut eirmod sed. Et eirmod sed amet labore sed nonumy molestie. Et lorem lobortis sadipscing suscipit stet ipsum ut dolor vero. Accusam ut nonumy ut esse sed dolores feugiat stet in rebum dolor dolores luptatum assum vero duo. Dolores nonummy quis in dolore ea ipsum dolores et ut ipsum invidunt eos et dolor invidunt augue rebum et. Vulputate sanctus gubergren. Erat gubergren at imperdiet eirmod exerci accusam dolor. Dolor ut sed nostrud.',
    width: 80,
    alignment: TextAlignment.left,
    style: CornerStyle.round,
  );

  return 0;
}
