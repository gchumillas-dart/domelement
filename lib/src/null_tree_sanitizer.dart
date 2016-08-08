part of domelement.src;

/// The only purpose propose of this class is allowing operate on
/// non-standard HTML entities.
class NullTreeSanitizer implements NodeTreeSanitizer {
  static NullTreeSanitizer _instance;

  factory NullTreeSanitizer() {
    if (_instance == null) {
      _instance = new NullTreeSanitizer._internal();
    }

    return _instance;
  }

  NullTreeSanitizer._internal();

  @override
  void sanitizeTree(Node node) {}
}
