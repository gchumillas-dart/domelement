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
  String get value {
    Element element = nativeElement;
    if (element is InputElement) {
      return element.value;
    } else {
      throw new UnsupportedError('Not an input element');
    }
  }

  set value(String v) {
    Element element = nativeElement;
    if (element is InputElement) {
      element.value = v;
    } else {
      throw new UnsupportedError('Not an input element');
    }
  }

  Element get nativeElement;
}

class _CssAttributeMap extends MapBase<String, String> {
  final Element _target;

  _CssAttributeMap(this._target);

  @override
  Iterable<String> get keys {
    return new List<String>.generate(
        _target.style.length, (int i) => _target.style.item(i));
  }

  @override
  String operator [](Object key) =>
      _target.style.getPropertyValue(key.toString());

  @override
  void operator []=(Object key, String value) =>
      _target.style.setProperty(key.toString(), value);

  @override
  void clear() =>
      keys.forEach((String key) => _target.style.removeProperty(key));

  @override
  String remove(Object key) => _target.style.removeProperty(key.toString());
}
