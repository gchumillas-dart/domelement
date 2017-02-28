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

  // see 'event' examples
  find('#button1')
      .nativeElement
      .onClick
      .listen((_) => pre.attr..remove('contenteditable')..remove('spellcheck'));
  find('#button2').nativeElement.onClick.listen((_) => pre.css.clear());
  find('#button3').nativeElement.onClick.listen((_) => pre.data.clear());
}
