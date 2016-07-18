import 'package:domelement/core.dart';

void main() {
  DomElement pre = find('#pre1')
    // makes the pre-formatted text editable
    ..attr['contenteditable'] = 'true'
    ..attr['spellcheck'] = 'true'
    // changes some CSS attributes
    ..css['white-space'] = 'pre-line'
    ..css['border'] = '1px solid #666'
    ..css['padding'] = '3px'
    // and saves some data
    ..data['hidden-text'] = 'This text is invisible';

  // prints some attributes info
  print('Is content editable: ' + pre.attr['contenteditable']);
  print('border: ' + pre.css['border'] + ', padding: ' + pre.css['padding']);
  print('Hidden text: ' + pre.data['hidden-text']);

  // see 'events' folder
  find('#button1').on('click', () {
    // removes all attributes except 'data' and 'style'
    pre.attr..remove('contenteditable')..remove('spellcheck');
  });
  find('#button2').on('click', () => pre.css.clear());
  find('#button3').on('click', () => pre.data.clear());
}
