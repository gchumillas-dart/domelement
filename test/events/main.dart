import 'dart:html';
import 'package:domelement/core.dart';

void main() {
  // Basic example
  find('#anchor1').on('click', () => print('Anchor 1: click!'));

  // Triggers an event and passes some data to the listener
  find('#anchor2')
    ..on('click', (Event event, String data) {
      print('Anchor 2: $data');
      return false;
    })
    ..trigger('click', data: 'Hello there!');

  // Processes the 'click' event only once
  bool listener(Event event) {
    DomElement target = $(event.target);
    print('Anchor 3: click!');
    // deattaches the listener from the target
    target.off('click', listener);

    // by returning false, this function stops the event from bubbling up
    // the chain and and prevents the default action in similar way
    return false;
  }
  find('#anchor3')..on('click', listener);
}
