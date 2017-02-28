import 'package:domelement/core.dart';

void updateControlPanel() {
  DomElement div1 = find('#div1');

  find('#width').value = '${div1.width}';
  find('#height').value = '${div1.height}';
  find('#border-width').value = '${div1.borderWidth}';
  find('#border-height').value = '${div1.borderHeight}';
  find('#padding-width').value = '${div1.paddingWidth}';
  find('#padding-height').value = '${div1.paddingHeight}';
  find('#margin-width').value = '${div1.marginWidth}';
  find('#margin-height').value = '${div1.marginHeight}';
}

void main() {
  find('#control-panel').nativeElement.onSubmit.listen((_) {
    try {
      find('#div1')
        ..width = int.parse(find('#width').value)
        ..height = int.parse(find('#height').value);
    } catch (exception) {
      print(exception);
    }
  });

  updateControlPanel();
}
