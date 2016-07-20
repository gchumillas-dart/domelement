part of domelement;

typedef void _Callback(DomElement target);

// TODO: implement appendTo and prependTo
abstract class ContentCapable {
  String get html => nativeElement.innerHtml;

  void set html(String value) =>
      nativeElement.setInnerHtml(value, treeSanitizer: new NullTreeSanitizer());

  Element get nativeElement;

  String get text => nativeElement.text;

  void set text(String value) {
    nativeElement.text = value;
  }

  /// This is a convenient function to create new element.
  /// For example:
  ///
  ///     final span = $('<p />')
  ///         ..append((target) {
  ///           target.appendString('<span>Some text here</span>');
  ///           target.appendString('<em>Cursive text here</em>');
  ///         });
  ///
  void append(_Callback callback) => callback(this);

  void appendTo(DomElement element, {bool prepend: false}) =>
      element.appendElement(this, prepend: prepend);

  void appendElement(DomElement element, {bool prepend: false}) {
    if (prepend) {
      List<Node> childNodes = nativeElement.childNodes;
      Node firstChild = childNodes.length > 0 ? childNodes.first : null;
      nativeElement.insertBefore(element.nativeElement, firstChild);
    } else {
      nativeElement.append(element.nativeElement);
    }
  }

  void appendString(String html, {bool prepend: false}) {
    nativeElement.insertAdjacentHtml(prepend ? 'beforeend' : 'afterbegin', html,
        treeSanitizer: new NullTreeSanitizer());
  }

  void empty() {
    while (nativeElement.hasChildNodes()) {
      nativeElement.firstChild.remove();
    }
  }
}
