library domelement;

import 'dart:collection';
import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'dart:mirrors' hide Comment;

import 'package:quiver/core.dart';

part 'dom_element.dart';
part 'src/attribute_capable.dart';
part 'src/class_capable.dart';
part 'src/content_capable.dart';
part 'src/event_capable.dart';
part 'src/size_capable.dart';
part 'src/null_tree_sanitizer.dart';

/// Use this function to create instances from different sources.
/// For example:
///
///     // creates a SPAN element
///     $('<span title="Span title">Some text..</span>');
///
///     // creates an element from a native element
///     DomElement root = $(document.documentElement);
///
DomElement $(dynamic /* String|Element|DomElement */ source) {
  DomElement node;
  if (source is String) {
    node = new DomElement.fromString(source);
  } else if (source is Element) {
    node = new DomElement.fromElement(source);
  } else if (source is DomElement) {
    // redundant but useful
    node = source;
  }
  return node;
}

/// Finds an element from the current document.
/// This function may return a null value if the element was not found.
DomElement find(String selectors) {
  Element element = querySelector(selectors);
  return element != null ? new DomElement.fromElement(element) : null;
}

/// Finds a list of elements from the current document.
List<DomElement> findAll(String selectors) => querySelectorAll(selectors)
    .map((Element element) => new DomElement.fromElement(element))
    .toList();
