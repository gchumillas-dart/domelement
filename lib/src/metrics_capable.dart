part of domelement;

abstract class MetricsCapable {
  num get borderHeight =>
      _getSumPropertyValues(['border-top-width', 'border-bottom-width']);

  num get borderWidth =>
      _getSumPropertyValues(['border-left-width', 'border-right-width']);

  num get height => _getSumPropertyValues(['height']);

  void set height(num value) {
    nativeElement.style.height = '${value}px';
  }

  num get marginHeight =>
      _getSumPropertyValues(['margin-top', 'margin-bottom']);

  num get marginWidth => _getSumPropertyValues(['margin-left', 'margin-right']);

  Element get nativeElement;

  num get paddingHeight =>
      _getSumPropertyValues(['padding-top', 'padding-bottom']);

  num get paddingWidth =>
      _getSumPropertyValues(['padding-left', 'padding-right']);

  num get width => _getSumPropertyValues(['width']);

  void set width(num value) {
    nativeElement.style.width = '${value}px';
  }

  num _getSumPropertyValues(List<String> propertyNames) {
    num ret = 0;

    CssStyleDeclaration style = nativeElement.getComputedStyle();
    for (String propertyName in propertyNames) {
      ret += _pixelToNum(style.getPropertyValue(propertyName));
    }

    return ret;
  }

  num _pixelToNum(String pixels) {
    return pixels.length > 0
        ? num.parse(pixels.replaceAll(new RegExp(r'px$'), ''))
        : 0;
  }
}
