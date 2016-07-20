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
element1.appendElement(element0, prepend: true);
```
The above example is only one of many examples in which the code can be drastically simplified. In any case, I would like to clarify that this library **does not pretend to replace** the official Dart API. But in most of cases you won't need to use it.

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

Use `DomElement.find()` and `DomElement.findAll()` to find elements **inside** another element:

```dart
final p1 = find('#p1');

// finds a single element
final span1 = p1.find('#span1');
if (span1 == null) {
  throw 'Element not found';
}

// finds multiple elements
final items = p1.findAll('span');
for (final item in item) {
  print(item);
}
```

## Creating elements

Let's create a new element and append it to the body's document:

```dart
final anchor = $('<a />')
  // sets some attributes
  ..attr['href'] = 'http://blah blah blah'
  ..attr['title'] = 'Anchor title'
  // sets some CSS attributes
  ..css['color'] = '#333'
  ..css['font-weight'] = 'bold'
  // sets inner texts
  ..text = 'Click here...';
find('body').appendElement(anchor);
```

## Responding to events

Use `on()`, `off()` and `trigger()` to operate events:

```dart
// prints an alert when clicking #anchor1
find('#anchor1').on('click', () => print('Click!'));

// dispatches an event and passes some extra info
find('#anchor2')
  ..on('click', (event, data) {
    print('Data: ${data}');
    // by returning 'false' stops the event from bubbling up
    // the event chain and prevents the default action
    // in similar way as jQuery does
    return false;
  })
  ..trigger('click', data: 'Hello there!');
```

## Limitations

As I mentioned previously this library does not pretend to replace the official Dart's library. It can't cover all cases, even though it covers the most common cases.

The most important limitation is that it operates only only over [DOM Elements](https://api.dartlang.org/stable/1.17.1/dart-html/Element-class.html). If you want to operate over other type of nodes (like [Texts](https://api.dartlang.org/stable/1.17.1/dart-html/Text-class.html) or [Comments](https://api.dartlang.org/stable/1.17.1/dart-html/Comment-class.html)), you'd better use the official Dart's library.
