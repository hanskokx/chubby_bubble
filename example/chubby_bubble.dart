import 'package:chubby_bubble/chubby_bubble.dart';

int main(List<String> arguments) {
  // const ChubbyBubble myFirstPanel = ChubbyBubble(
  //   backgroundColor: AnsiColor.white,
  //   child: ChubbyPanel(
  //     text: 'This is a story of how my life got flipped turned upside down.',
  //     width: 20,
  //     alignment: TextAlignment.left,
  //   ),
  // );

  // myFirstPanel.render();

  // const ChubbyBubble myPanel = ChubbyBubble(
  //   backgroundColor: AnsiColor.brightCyan,
  //   child: ChubbyPanel(
  //     text:
  //         'Takimata no consectetuer dolor iriure dolore. Takimata sea luptatum euismod dolor eu dolore eirmod tation nonumy aliquyam. Ipsum eirmod erat tempor sadipscing ipsum dolore et sed sea diam stet aliquyam possim eleifend no gubergren. Rebum gubergren mazim dolore et commodo magna ipsum rebum luptatum blandit et. Ut clita diam suscipit dolor erat dolore hendrerit sadipscing nostrud erat et lorem magna sit rebum. Dolore ipsum diam dolor no sed feugiat et takimata dolore lorem sed tation sit dignissim clita. Et amet nonumy ut gubergren sit lobortis dolores et amet rebum justo consetetur invidunt ut eirmod sed. Et eirmod sed amet labore sed nonumy molestie. Et lorem lobortis sadipscing suscipit stet ipsum ut dolor vero. Accusam ut nonumy ut esse sed dolores feugiat stet in rebum dolor dolores luptatum assum vero duo. Dolores nonummy quis in dolore ea ipsum dolores et ut ipsum invidunt eos et dolor invidunt augue rebum et. Vulputate sanctus gubergren. Erat gubergren at imperdiet eirmod exerci accusam dolor. Dolor ut sed nostrud.',
  //     width: 40,
  //     alignment: TextAlignment.right,
  //     style: ChubbyPanelStyle(
  //       cornerStyle: CornerStyle.round,
  //     ),
  //   ),
  // );

  // myPanel.render();

  const ChubbyBubble myBubble = ChubbyBubble(
    child: ChubbyPanel(
      text:
          'Takimata no consectetuer dolor iriure dolore. Takimata sea luptatum euismod dolor eu dolore eirmod tation nonumy aliquyam. Ipsum eirmod erat tempor sadipscing ipsum dolore et sed sea diam stet aliquyam possim eleifend no gubergren. Rebum gubergren mazim dolore et commodo magna ipsum rebum luptatum blandit et. Ut clita diam suscipit dolor erat dolore hendrerit sadipscing nostrud erat et lorem magna sit rebum. Dolore ipsum diam dolor no sed feugiat et takimata dolore lorem sed tation sit dignissim clita. Et amet nonumy ut gubergren sit lobortis dolores et amet rebum justo consetetur invidunt ut eirmod sed. Et eirmod sed amet labore sed nonumy molestie. Et lorem lobortis sadipscing suscipit stet ipsum ut dolor vero. Accusam ut nonumy ut esse sed dolores feugiat stet in rebum dolor dolores luptatum assum vero duo. Dolores nonummy quis in dolore ea ipsum dolores et ut ipsum invidunt eos et dolor invidunt augue rebum et. Vulputate sanctus gubergren. Erat gubergren at imperdiet eirmod exerci accusam dolor. Dolor ut sed nostrud.',
      width: 80,
      alignment: TextAlignment.center,
      style: ChubbyPanelStyle(
        cornerStyle: CornerStyle.round,
        backgroundColor: AnsiColor.brightYellow,
      ),
      title: ChubbyPanelTitle(
        'Hello, ChubbyBubble',
        style: ChubbyPanelStyle(
          cornerStyle: CornerStyle.none,
          edgeStyle: EdgeStyle.none,
          backgroundColor: AnsiColor.brightMagenta,
          textStyle: ChubbyTextStyle(
            bold: true,
            italic: true,
            color: AnsiColor.brightCyan,
          ),
        ),
      ),
      child: ChubbyPanel(
        text: 'Hello',
        style: ChubbyPanelStyle(
          edgeStyle: EdgeStyle.double,
          cornerStyle: CornerStyle.double,
          borderColor: AnsiColor.brightGreen,
          backgroundColor: AnsiColor.brightWhite,
        ),
      ),
    ),
  );

  myBubble.render();

  return 0;
}
