part of domelement;

class DomElement extends Object
    with
        AttributeCapable,
        ClassCapable,
        ContentCapable,
        CssCapable,
        EventCapable,
        MetricsCapable {
  Element _nativeElement;

  DomElement.fromElement(this._nativeElement);

  DomElement.fromString(String html) {
    // removes the self-closing tags
    html = html.replaceAllMapped(
        new RegExp(r'<\s*(\w+)([^>]*)/>', multiLine: true), (Match m) {
      List<String> s = [m[1], m[2]]
          .map((String item) => item?.trim())
          .where((String item) => item != null && item.length > 0);
      return '<${s.join(' ')}></${m[1]}>';
    });

    DocumentFragment fragment = document.createDocumentFragment();
    fragment.appendHtml(html, treeSanitizer: new NullTreeSanitizer());

    if (fragment.children.length != 1) {
      throw new ArgumentError('Invalid HTML tag');
    }

    _nativeElement = fragment.children.first;
  }

  String get name => _nativeElement.nodeName?.toLowerCase();

  Element get nativeElement => _nativeElement;

  DomElement get parent => _nativeElement.parent != null
      ? new DomElement.fromElement(_nativeElement.parent)
      : null;

  /// The only purpose of the function is to facilitate the creation of new
  /// elements. For instance:
  ///
  ///     $('<span />')
  ///       ..attr['id'] = 'span_1'
  ///       ..css['color'] = 'red'
  ///       ..apply((target) {
  ///         // appends some internal structures
  ///         target.appendHtml('some contents here');
  ///         target.prependElement($('<p>Some text</p>'));
  ///       });
  ///
  void apply(void callback(DomElement element)) {
    callback(this);
  }

  List<DomElement> findAll(String selectors) => _nativeElement
      .querySelectorAll(selectors)
      .map((Element element) => new DomElement.fromElement(element));

  void remove() => nativeElement.remove();

  String toString() => _node2String(nativeElement);

  String _node2String(Node node) {
    StringBuffer str = new StringBuffer();

    if (node is Text) {
      str.write(node.text);
    } else if (node is Comment) {
      str.write('<!--${node.text}-->');
    } else if (node is Element) {
      HtmlEscape escape = const HtmlEscape(HtmlEscapeMode.ATTRIBUTE);
      String tagName = node.nodeName.toLowerCase();

      str.write('<$tagName');

      node.attributes.forEach((String attrName, String value) {
        str.write(' $attrName="${escape.convert(value)}"');
      });

      if (node.childNodes.length > 0) {
        str.write('>');

        node.childNodes.forEach((Node item) {
          str.write(_node2String(item));
        });

        str.write('</$tagName>');
      } else {
        str.write(' />');
      }
    }

    return str.toString();
  }
}
