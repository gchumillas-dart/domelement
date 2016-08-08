part of domelement.src;

abstract class SizeCapable {
  /// Gets border height.
  num get borderHeight => _getSumPropertyValues(
      <String>['border-top-width', 'border-bottom-width']);

  /// Gets border width.
  num get borderWidth => _getSumPropertyValues(
      <String>['border-left-width', 'border-right-width']);

  /// Gets or Sets height.
  num get height => _getSumPropertyValues(<String>['height']);
  void set height(num value) {
    nativeElement.style.height = '${value}px';
  }

  /// Gets margin height.
  num get marginHeight =>
      _getSumPropertyValues(<String>['margin-top', 'margin-bottom']);

  /// Gets margin width.
  num get marginWidth =>
      _getSumPropertyValues(<String>['margin-left', 'margin-right']);

  Element get nativeElement;

  /// Gets padding height.
  num get paddingHeight =>
      _getSumPropertyValues(<String>['padding-top', 'padding-bottom']);

  /// Gets padding width.
  num get paddingWidth =>
      _getSumPropertyValues(<String>['padding-left', 'padding-right']);

  /// Gets or sets height.
  num get width => _getSumPropertyValues(<String>['width']);
  void set width(num value) {
    nativeElement.style.width = '${value}px';
  }

  /// Calculates the total sum of individual properties values.
  num _getSumPropertyValues(List<String> propertyNames) {
    num ret = 0;

    CssStyleDeclaration style = nativeElement.getComputedStyle();
    for (String propertyName in propertyNames) {
      ret += _pixelToNum(style.getPropertyValue(propertyName));
    }

    return ret;
  }

  /// Transforms [pixels] into a number.
  num _pixelToNum(String pixels) {
    return pixels.length > 0
        ? num.parse(pixels.replaceAll(new RegExp(r'px$'), ''))
        : 0;
  }
}
