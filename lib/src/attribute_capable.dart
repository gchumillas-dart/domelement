part of domelement;

abstract class AttributeCapable {
  Map<String, String> get attr => nativeElement.attributes;
  Map<String, String> get css => new _CssAttributeMap(nativeElement);
  Map<String, String> get data => nativeElement.dataset;
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
