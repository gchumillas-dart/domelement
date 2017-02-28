import 'package:domelement/core.dart';

void main() {
  DomElement div = find('#div1');

  find('#button1').nativeElement.onClick.listen((_) => div.addClass('class1'));
  find('#button2')
      .nativeElement
      .onClick
      .listen((_) => div.removeClass('class1'));
  find('#button3')
      .nativeElement
      .onClick
      .listen((_) => div.toggleClass('class1'));
  find('#button4')
      .nativeElement
      .onClick
      .listen((_) => print(div.hasClass('class1')));
}
