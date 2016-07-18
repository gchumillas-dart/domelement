part of domelement;

abstract class AttributeCapable {
  Map<String, String> get attr => new _AttrMap(nativeElement);

  set attr(Map<String, String> value) {
    attr.clear();
    value.forEach((String key, String value) {
      attr[key] = value;
    });
  }

  Map<String, Object> get data => new _DataMap(nativeElement);

  set data(Map<String, Object> value) {
    data.clear();
    value.forEach((String key, Object value) {
      data[key] = value;
    });
  }

  Element get nativeElement;
}

class _AttrMap extends MapBase<String, String> {
  final Element _target;

  _AttrMap(this._target);

  Iterable<String> get keys => _target.attributes.keys;

  String operator [](Object key) => _target.getAttribute(key.toString());

  void operator []=(String key, String value) =>
      _target.setAttribute(key, value);

  void clear() => _target.attributes.clear();

  String remove(Object key) => _target.attributes.remove(key.toString());
}

// TODO: should extends MapBase<String, Object>
class _DataMap extends _AttrMap {
  _DataMap(Element target) : super(target);

  Iterable<String> get keys {
    return super
        .keys
        .where((String key) => key.startsWith('data-'))
        .map((String key) => key.replaceFirst('data-', ''));
  }

  String operator [](Object key) {
    String value = super[['data', key.toString()].join('-')];
    return value != null ? JSON.decode(value) : null;
  }

  void operator []=(String key, String value) {
    super[['data', key].join('-')] = JSON.encode(value);
  }

  void clear() {
    _target.attributes.keys
        .where((String key) => key.startsWith('data-'))
        .forEach((String key) => _target.attributes.remove(key));
  }

  String remove(Object key) {
    return super.remove(['data', key].join('-'));
  }
}
