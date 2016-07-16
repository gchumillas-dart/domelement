part of domelement;

abstract class CssCapable {
  Map<String, String> get css => new _CssMap(nativeElement);

  set css(Map<String, String> value) {
    css.clear();
    value.forEach((String key, String value) {
      css[key] = value;
    });
  }

  Element get nativeElement;
}

class _CssMap extends MapBase<String, String> {
  final Element _target;

  _CssMap(this._target);

  Iterable<String> get keys => _getCssAttrMap(_target).keys;

  String operator [](Object key) => _getCssAttrMap(_target)[key.toString()];

  void operator []=(String key, String value) {
    Map<String, String> attrs = _getCssAttrMap(_target);
    attrs[key] = value;
    _setCssAttrMap(_target, attrs);
  }

  void clear() => _setCssAttrMap(_target, {});

  String remove(Object key) {
    String ret;
    Map<String, String> attrs = _getCssAttrMap(_target);
    ret = attrs.remove(key.toString());
    _setCssAttrMap(_target, attrs);
    return ret;
  }

  Map<String, String> _getCssAttrMap(Element element) {
    Map<String, String> ret = new Map<String, String>();
    String css = element.getAttribute('style');

    if (css != null) {
      css.split(';').forEach((String cssAttr) {
        List<String> item = cssAttr.split(':');
        String key = item.length > 0 ? item[0].trim().toLowerCase() : '';
        String value = item.length > 1 ? item[1].trim() : '';

        if (key.length > 0 && value.length > 0) {
          ret[key] = value;
        }
      });
    }

    return ret;
  }

  void _setCssAttrMap(Element element, Map<String, String> attrs) {
    List<String> arr = [];

    attrs.keys.forEach((String key) {
      if (key != null && key.length > 0) {
        arr.add(key.toLowerCase() + ': ' + attrs[key]);
      }
    });

    element.setAttribute('style', arr.join('; '));
  }
}
