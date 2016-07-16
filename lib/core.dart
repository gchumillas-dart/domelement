library domelement;

import 'dart:collection';
import 'dart:convert';
import 'dart:html';
import 'dart:mirrors' hide Comment;

import 'package:html_unescape/html_unescape.dart';

part 'dom_element.dart';
part 'src/attribute_capable.dart';
part 'src/class_capable.dart';
part 'src/content_capable.dart';
part 'src/css_capable.dart';
part 'src/event_capable.dart';
part 'src/metrics_capable.dart';
part 'src/null_tree_sanitizer.dart';

DomElement $(String html) => new DomElement.fromString(html);

DomElement find(String selectors) {
  Element element = querySelector(selectors);
  return element != null ? new DomElement(element) : null;
}

List<DomElement> findAll(String selectors) => querySelectorAll(selectors)
    .map((Element element) => new DomElement(element));
