part of domelement;

class DomElement extends Object
    with AttributeCapable, ClassCapable, ContentCapable, SizeCapable {
  Element _nativeElement;

  /// Creates an instance from a tag name.
  DomElement(String tagName) {
    _nativeElement = document.createElement(tagName);
  }

  /// Creates an instance from a native element.
  DomElement.fromElement(this._nativeElement);

  /// Creates an instance from a HTML string.
  ///
  /// For example:
  ///
  ///     final element = new DomElement.fromString(
  ///       '<span style="border: 1px solid red">Some text</span>');
  ///
  DomElement.fromString(String html) {
    // removes the self-closing tags
    html = html.replaceAllMapped(
        new RegExp(r'<([a-z0-9\-\.]+)([^>]*)/>',
            multiLine: true, caseSensitive: false), (Match matches) {
      String tagName = matches[1];
      String attributes = matches[2].replaceAll(new RegExp(r'\s+$'), '');
      String leftSide = <String>[tagName, attributes]
          .where((String item) => item.length > 0)
          .join();
      return '<$leftSide></$tagName>';
    });

    _TagSanitizer sanitizer = new _TagSanitizer();
    html = sanitizer.suffixReservedTags(html);

    DocumentFragment fragment = document.createDocumentFragment();
    fragment.appendHtml(html, treeSanitizer: new NullTreeSanitizer());
    if (fragment.children.length != 1) {
      throw new DocumentError('Invalid HTML');
      //throw new ArgumentError('Invalid HTML');
    }

    _nativeElement =
        sanitizer.removeSuffixFromElementTree(fragment.children.first);
  }

  /// Gets the element tag name.
  String get name => _nativeElement.nodeName?.toLowerCase();

  /// Gets the native element.
  @override
  Element get nativeElement => _nativeElement;

  /// Gets the parent element.
  ///
  /// This function may return `null` if the element has no parent.
  DomElement get parent => _nativeElement.parent != null
      ? new DomElement.fromElement(_nativeElement.parent)
      : null;

  /// Finds a element by a CSS [selectors].
  DomElement find(String selectors) {
    Element element = _nativeElement.querySelector(selectors);
    return element != null ? new DomElement.fromElement(element) : null;
  }

  /// Finds a list of elements by a CSS [selectors].
  List<DomElement> findAll(String selectors) => _nativeElement
      .querySelectorAll(selectors)
      .map((Element element) => new DomElement.fromElement(element))
      .toList();

  /// Removes [this] instance from the current document.
  void remove() => nativeElement.remove();

  /// Gets a string representation of [this] instance.
  @override
  String toString() => _node2String(nativeElement);

  /// Prints a string representation of a node.
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

/// This class solves a problem with Document.createDocumentFragment().
/// It ignores some reserved tags, like TD, TR, TBODY, etc...
/// This class suffix the reserved tags and then removes those suffixes.
///
/// For example:
///
///     final sanitizer = new _TagSanitizer();
///
///     // suffixes the reserved tags
///     sanitizer.suffixReservedTags(html);
///
///     // creates an element from an arbitrary HTML string
///     final fragment = document.createDocumentFragment();
///     fragment.appendHtml(html, treeSanitizer: new NullTreeSanitizer());
///     final element = fragment.children.first;
///
///     // removes suffixes from the element and its child nodes
///     element = sanitizer.removeSuffixFromElementTree(element);
///
class _TagSanitizer {
  static List<String> _reservedTags = <String>[
    'td',
    'tr',
    'tbody',
    'thead',
    'tfooter'
  ];
  String _suffix;

  _TagSanitizer() {
    // generates a random suffix
    Random r = new Random.secure();
    String randomSequence =
        new List<String>.generate(12, (int i) => r.nextInt(100).toString())
            .join();
    _suffix = 'suffix$randomSequence';
  }

  /// Removes the suffixes from the element and its child nodes
  Element removeSuffixFromElementTree(Element element) {
    Element ret = element;

    element.nodeName.replaceAllMapped(
        new RegExp(_suffix + r'-(\w+)', caseSensitive: false), (Match matches) {
      String tagName = matches[1];
      ret = _renameElement(element, tagName);
      for (Element item in ret.children) {
        removeSuffixFromElementTree(item);
      }
    });
    return ret;
  }

  /// Prepends a suffix to the reserved tags
  String suffixReservedTags(String html) {
    String ret =
        html.replaceAllMapped(new RegExp(r'<(\w+)([^>]*)>'), (Match matches) {
      String tagName = _reservedTags.contains(matches[1])
          ? _suffix + '-' + matches[1]
          : matches[1];
      String attributes = matches[2].replaceAll(new RegExp(r'\s+$'), '');
      String leftSide = <String>[tagName, attributes]
          .where((String item) => item.length > 0)
          .join();
      return '<$leftSide>';
    });

    ret = ret.replaceAllMapped(new RegExp(r'</(\w+)>'), (Match matches) {
      String tagName = matches[1] ?? '';
      if (_reservedTags.contains(tagName)) {
        tagName = _suffix + '-' + tagName;
      }
      return '</$tagName>';
    });

    return ret;
  }

  Element _renameElement(Element element, String newName) {
    Element renamedElement = document.createElement(newName);

    // copies attributes
    renamedElement.attributes = element.attributes;

    // moves child nodes
    while (element.hasChildNodes()) {
      renamedElement.append(element.firstChild);
    }

    return element.parent != null
        ? element.replaceWith(renamedElement)
        : renamedElement;
  }
}
