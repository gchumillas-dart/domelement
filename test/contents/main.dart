import 'dart:html';
import 'package:domelement/core.dart';

void main() {
  // creates a table and appends it to the body
  // The 'append' method can be used to add internal structures to the recently
  // created element
  $('<table />')
    ..add((DomElement table) {
      List<Map<String, String>> items = [
        {'firstName': 'John', 'lastName': 'Smith'},
        {'firstName': 'Antonio', 'lastName': 'López'},
        {'firstName': 'Eva', 'lastName': 'Garrido'}
      ];
      table
        ..appendElement($('<thead />')
          ..appendString('<tr><th>First Name</th><th>Last Name</th></tr>'))
        ..appendElement($('<tbody />')
          ..add((DomElement tbody) {
            for (Map<String, String> item in items) {
              $('<tr />')
                ..appendElement($('<td />')..text = item['firstName'])
                ..appendElement($('<td />')..text = item['lastName'])
                ..appendTo(tbody);
            }
          }));
    })
    ..appendTo(find('body'));

  // changes some inner html texts
  DomElement ul = find('#ul1');
  List<DomElement> ulItems = ul.findAll('li');
  for (int i = 0; i < ulItems.length; i++) {
    DomElement item = ulItems[i];
    item.html = 'Item &amp; ${i + 1}';
    print(item.html);
  }

  // changes inner texts
  find('#p1')..text = 'Jack & John';
  print(find('#p1').text);

  // appends HTML texts
  find('#p2')
    ..appendString('--Text added to the end')
    ..appendString('Text added to the beggining--');

  // appends elements
  Element span1 = document.createElement('span');
  Element span2 = document.createElement('span');
  find('#p3')..appendElement($(span1))..appendElement($(span2));
  span1.text = '--Span added to the end';
  span2.text = 'Span added to the beggining--';

  // changes internal structures
  find('#div1')
    ..add((DomElement target) {
      target.appendString('<p>Lorem Ipsum<br>Dolor Sit<br>Amet</p>');
    });

  // creates a new element from scratch
  // you can create non-standard elements on the fly
  DomElement root = $('<root />')
    ..add((DomElement target) {
      for (int i = 0; i < 3; i++) {
        target.appendElement($('<item />')
          ..attr['title'] = 'Title ${i}'
          ..text = 'Text ${i}');
      }
    });
  print(root);
}
