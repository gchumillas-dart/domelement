# DomElement

The [dart:html](https://api.dartlang.org/stable/1.17.1/dart-html/dart-html-library.html) library provides a set of functions and classes to access DOM nodes. But, sometimes, making the most simple and common operations results in a counterintuitive experience. For instance, let's say that you want to 'prepend' some element into another element:

```dart
// prepends element0 into element1
final element0 = querySelector('#element0');
final element1 = querySelector('#element1');
if (element1.hasChildNodes()) {
  element1.insertBefore(element0, element1.childNodes.first);
} else {
  element1.append(element0);
}
```

Using this library the previous code can be written as follows:

```dart
// prepends element0 into element1
final element0 = find('#element0');
final element1 = find('#element1');
element1.addElement(element0, prepend: true);
```
The above example is only one of many examples in which the code can be drastically simplified. In any case, I would like to remark that this library **does not pretend to replace** the official Dart's library. But in most cases you won't need to use it.

## Install

Edit your `pubspec.yaml` and add the library dependency:

```yaml
dependencies:
  # specify the version number, for example ^0.0.1
  domelement: <version number>
```

Alternatively, you can pull the library from the GitHub repository:
```yaml
domelement:
  # specify the tag name, for example v0.0.1 (ref entry can be omitted)
  git:
    url: git://github.com/soloproyectos-dart/domelement.git
    ref: <tag name>
```

And then gets the dependencies:

```bash
> pub get
```

Finally, import the library from the source code:

```dart
import 'package:domelement/core.dart';

void main() {
  final element = find('#element_id');
  print(element);
}
```

## Finding elements

Use `find()` and `findAll()` to select elements from the current document:

```dart
// finds a single element
final p1 = find('#p1');
if (p1 == null) {
  throw 'Item not found';
}

// finds multiple elements
final items = findAll('p');
for (final item in items) {
  print(item);
}
```

## Creating elements

Use the `$()` function to create elements. For example:

```dart
// creates an anchor element and appends it to the document's body
final anchor = $('<a />')
  // sets some attributes
  ..attr['href'] = 'http://blah blah blah'
  ..attr['title'] = 'Anchor title'
  // sets some CSS attributes
  ..css['color'] = '#333'
  ..css['font-weight'] = 'bold'
  // sets inner texts
  ..text = 'Click here...';
find('body').addElement(anchor);

// creates an element from a previous native element
final root = $(document.documentElement);
print(root);
```

The `$('<a />')` expression is equivalent to `new DomElement.fromString('<a />')`. And `$(document.documentElement)` is equivalent to `new DomElement.fromElement(document.documentElement)`.

## Limitations

As I mentioned previously this library does not pretend to replace the official Dart's library. It can't cover all cases, even though it covers the most common cases.

The most important limitation is that it operates only over [DOM Elements](https://api.dartlang.org/stable/1.17.1/dart-html/Element-class.html). If you want to operate over other type of nodes (like [Texts](https://api.dartlang.org/stable/1.17.1/dart-html/Text-class.html) or [Comments](https://api.dartlang.org/stable/1.17.1/dart-html/Comment-class.html)), you'd better use the official Dart's library.

## Additional info

For additional info, check out the API documentation:  
https://www.dartdocs.org/documentation/domelement/0.0.1/domelement/domelement-library.html
