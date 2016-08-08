part of domelement.src;

typedef void _Callback(DomElement target);

abstract class ContentCapable {
  /// Gets or sets inner HTML contents.
  String get html => nativeElement.innerHtml;
  set html(String value) =>
      nativeElement.setInnerHtml(value, treeSanitizer: new NullTreeSanitizer());

  Element get nativeElement;

  /// Gets or sets inner text contents.
  String get text => nativeElement.text;

  set text(String value) {
    nativeElement.text = value;
  }

  /// This is a convenient function to create internal structures.
  ///
  /// For example:
  ///
  ///     // creates a new element and adds internal structures
  ///     final span = $('<p />')
  ///         ..add((target) {
  ///           // appends some nodes
  ///           target.addString('<span>Some text here</span>');
  ///           target.addString('<em>Cursive text here</em>');
  ///         });
  ///
  void add(_Callback callback) => callback(this);

  /// Adds the [this] instance into [element].
  void addTo(DomElement element, {bool prepend: false}) =>
      element.addElement(this, prepend: prepend);

  /// Adds an [element] into [this] instance.
  ///
  /// The [prepend] flag determines whether the [element] is added to the
  /// beggining or the end.
  void addElement(DomElement element, {bool prepend: false}) {
    if (prepend) {
      List<Node> childNodes = nativeElement.childNodes;
      Node firstChild = childNodes.length > 0 ? childNodes.first : null;
      nativeElement.insertBefore(element.nativeElement, firstChild);
    } else {
      nativeElement.append(element.nativeElement);
    }
  }

  /// Adds a HTML string.
  void addString(String html, {bool prepend: false}) {
    nativeElement.insertAdjacentHtml(prepend ? 'beforeend' : 'afterbegin', html,
        treeSanitizer: new NullTreeSanitizer());
  }

  /// Removes all child nodes.
  void empty() {
    while (nativeElement.hasChildNodes()) {
      nativeElement.firstChild.remove();
    }
  }
}
