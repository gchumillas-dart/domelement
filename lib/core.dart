library domelement;

import 'dart:collection';
import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'dart:mirrors' hide Comment;

import 'package:html_unescape/html_unescape.dart';
import 'package:quiver/core.dart';

part 'dom_element.dart';
part 'src/attribute_capable.dart';
part 'src/class_capable.dart';
part 'src/content_capable.dart';
part 'src/event_capable.dart';
part 'src/metrics_capable.dart';
part 'src/null_tree_sanitizer.dart';

/// This function allow to create instances from different sources.
/// For example:
///
///     // The following command is equivalent to ...
///     $('<span title="Span title">Some text..</span>');
///
///     // the following command
///     DomElement elem = new DomElement('span')
///       ..attr['title'] = 'Some title'
///       ..text = 'Some text';
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
    .map((Element element) => new DomElement.fromElement(element));
