import 'package:domelement/core.dart';

void main() {
  // finds a single element and changes some CSS attributes
  DomElement p1 = find('#p1');
  if (p1 == null) {
    throw new Exception('Item not found');
  }
  p1
    ..css['color'] = '#333'
    ..css['font-size'] = '28px'
    ..css['font-weight'] = 'bold';

  // finds multiple elements and changes some CSS attributes
  List<DomElement> pItems = findAll('p:not(#p1)');
  for (DomElement item in pItems) {
    item
      ..css['color'] = '#666'
      ..css['font-size'] = '24px';
  }

  // finds a single element inside another element
  DomElement span1 = p1.find('#span1');
  if (span1 == null) {
    throw new Exception('Item not found');
  }
  span1.css['color'] = 'red';

  // finds multiple elements inside another element
  List<DomElement> spanItems = p1.findAll('span:not(#span1)');
  for (DomElement item in spanItems) {
    item.css['color'] = 'brown';
  }
}
