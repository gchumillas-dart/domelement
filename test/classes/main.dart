import 'package:domelement/core.dart';

void main() {
  DomElement div = find('#div1');

  find('#button1').on('click', () => div.addClass('class1'));
  find('#button2').on('click', () => div.removeClass('class1'));
  find('#button3').on('click', () => div.toggleClass('class1'));
  find('#button4').on('click', () => print(div.hasClass('class1')));
}
