part of domelement.src;

abstract class ClassCapable {
  Element get nativeElement;

  /// Adds a CSS class.
  void addClass(String className) {
    nativeElement.classes.add(className);
  }

  /// Checks if the element contains a CSS class.
  bool hasClass(String className) => nativeElement.classes.contains(className);

  /// Removes a CSS class.
  void removeClass(String className) {
    nativeElement.classes.remove(className);
  }

  /// Adds or removes a CSS class.
  ///
  /// Adds or removes a CSS class, depending on the class
  /// was already present or not.
  void toggleClass(String className) {
    hasClass(className) ? removeClass(className) : addClass(className);
  }
}
