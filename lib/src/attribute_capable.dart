part of domelement.src;

abstract class AttributeCapable {
  /// Accesses element attributes
  ///
  /// For example:
  ///
  ///     element.attr['title'] = 'Element title';
  ///     print(element.attr['title']);
  ///
  Map<String, String> get attr => nativeElement.attributes;

  /// Accesses CSS attributes.
  ///
  /// For example:
  ///
  ///     element.css['border'] = '1px solid red';
  ///     print(element.css['border']);
  ///
  Map<String, String> get css => new _CssAttributeMap(nativeElement);

  /// Accesses data attributes.
  ///
  ///
  /// For example:
  ///
  ///     element.data['text'] = 'Some text';
  ///     print(element.data['text']);
  ///
  /// See also:
  ///
  /// [HTMLElement.dataset](https://developer.mozilla.org/es/docs/Web/API/HTMLElement/dataset)
  ///
  Map<String, String> get data => nativeElement.dataset;

  /// Input value.
  ///
  /// This function may throw an exception if the target
  /// is not an input element.
  String get value => (nativeElement as InputElement).value;
  void set value(String v) {
    (nativeElement as InputElement).value = v;
  }

  Element get nativeElement;
}

class _CssAttributeMap extends MapBase<String, String> {
  final Element _target;

  _CssAttributeMap(this._target);

  Iterable<String> get keys {
    return new List<String>.generate(
        _target.style.length, (int i) => _target.style.item(i));
  }

  String operator [](Object key) =>
      _target.style.getPropertyValue(key.toString());

  void operator []=(Object key, String value) =>
      _target.style.setProperty(key.toString(), value);

  void clear() =>
      keys.forEach((String key) => _target.style.removeProperty(key));

  String remove(Object key) => _target.style.removeProperty(key.toString());
}
