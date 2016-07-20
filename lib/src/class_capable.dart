part of domelement.src;

abstract class ClassCapable {
  Element get nativeElement;

  void addClass(String className) {
    nativeElement.classes.add(className);
  }

  bool hasClass(String className) => nativeElement.classes.contains(className);

  void removeClass(String className) {
    nativeElement.classes.remove(className);
  }

  void toggleClass(String className) {
    hasClass(className) ? removeClass(className) : addClass(className);
  }
}
