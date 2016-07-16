part of domelement;

class NullTreeSanitizer implements NodeTreeSanitizer {
  static NullTreeSanitizer _instance;

  factory NullTreeSanitizer() {
    if (_instance == null) {
      _instance = new NullTreeSanitizer._internal();
    }

    return _instance;
  }

  NullTreeSanitizer._internal();

  void sanitizeTree(Node node) {}
}
