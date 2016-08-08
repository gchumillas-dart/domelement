library domelement.exception;

/// Error thrown when the passed document is not well formed.
class DocumentError extends ArgumentError {
  DocumentError(String message) : super(message);
}
