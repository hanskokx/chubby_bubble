import 'package:chubby_bubble/features/panel.dart';

void main(List<String> arguments) {
  Panel(
    'Hello world!',
    width: 80,
    title: PanelTitle("Hey."),
  ).render();
}
