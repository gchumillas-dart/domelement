import 'dart:html';
import 'package:domelement/core.dart';

/// Processes the 'click' event and deattached it from the target
void onAnchor3Click(Event event) {
  DomElement target = new DomElement(event.target);
  print('Anchor 3: click!');
  target.off('click', onAnchor3Click);
}

void main() {
  // Basic example
  find('#anchor1').on('click', () => print('Anchor 1: click!'));

  // Triggers an event and passes some data to the listener
  find('#anchor2')
    ..on('click', (Event event, String data) => print('Anchor 2: ${data}'))
    ..trigger('click', data: 'Hello there!');

  // Processes the 'click' event only once
  find('#anchor3')..on('click', onAnchor3Click);
}
