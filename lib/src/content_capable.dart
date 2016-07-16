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

  void appendElement(DomElement element) {
    nativeElement.append(element.nativeElement);
  }

  void appendHtml(String html) =>
      nativeElement.insertAdjacentHtml('beforeend', html,
          treeSanitizer: new NullTreeSanitizer());

  void empty() {
    while (nativeElement.hasChildNodes()) {
      nativeElement.firstChild.remove();
    }
  }

  void prependElement(DomElement element) {
    nativeElement.append(element.nativeElement);
  }

  void prependHtml(String html) =>
      nativeElement.insertAdjacentHtml('afterbegin', html,
          treeSanitizer: new NullTreeSanitizer());
}
