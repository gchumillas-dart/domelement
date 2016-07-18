part of domelement;

abstract class ContentCapable {
  String get html => nativeElement.innerHtml;

  void set html(String value) =>
      nativeElement.setInnerHtml(value, treeSanitizer: new NullTreeSanitizer());

  Element get nativeElement;

  String get text => new HtmlUnescape().convert(nativeElement.text);

  void set text(String value) {
    nativeElement.text = new HtmlEscape().convert(value);
  }

  void append(dynamic /* String|Element|DomElement */ source) {
    if (source is String) {
      nativeElement.insertAdjacentHtml('beforeend', source,
          treeSanitizer: new NullTreeSanitizer());
    } else if (source is Element || source is DomElement) {
      DomElement element =
          source is Element ? new DomElement.fromElement(source) : source;
      nativeElement.append(element.nativeElement);
    } else {
      throw new ArgumentError('Valid values are: String|Element|DomElement');
    }
  }

  void empty() {
    while (nativeElement.hasChildNodes()) {
      nativeElement.firstChild.remove();
    }
  }

  void prepend(dynamic /* String|Element|DomElement */ source) {
    if (source is String) {
      nativeElement.insertAdjacentHtml('afterbegin', source,
          treeSanitizer: new NullTreeSanitizer());
    } else if (source is Element || source is DomElement) {
      DomElement element =
          source is Element ? new DomElement.fromElement(source) : source;
      List<Node> childNodes = nativeElement.childNodes;
      Node firstChild = childNodes.length > 0 ? childNodes.first : null;
      nativeElement.insertBefore(element.nativeElement, firstChild);
    } else {
      throw new ArgumentError('Valid values are: String|Element|DomElement');
    }
  }
}
