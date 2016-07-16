part of domelement;

abstract class ClassCapable {
  Element get nativeElement;

  void addClass(String className) {
    List<String> classes = _getClassMap(nativeElement);
    if (!classes.contains(className)) {
      classes.add(className);
      _setClassMap(nativeElement, classes);
    }
  }

  bool hasClass(String className) {
    List<String> classes = _getClassMap(nativeElement);
    return classes.contains(className);
  }

  void removeClass(String className) {
    List<String> classes = _getClassMap(nativeElement);
    classes.remove(className);
    _setClassMap(nativeElement, classes);
  }

  void toggleClass(String className) {
    hasClass(className) ? removeClass(className) : addClass(className);
  }

  List<String> _getClassMap(Element element) {
    List<String> ret = new List<String>();
    String classAttr = element.getAttribute('class');

    if (classAttr != null) {
      List<String> classes = classAttr.trim().split(new RegExp(r'\s+'));

      classes.forEach((String className) {
        if (className.length > 0 && !ret.contains(className)) {
          ret.add(className);
        }
      });
    }

    return ret;
  }

  void _setClassMap(Element element, List<String> classes) {
    element.setAttribute('class', classes.join(' '));
  }
}
