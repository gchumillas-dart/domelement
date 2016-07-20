# DomElement

The [dart:html](https://api.dartlang.org/stable/1.17.1/dart-html/dart-html-library.html) library provides a set of functions and classes to access DOM nodes. But, sometimes, making the most simple and common operations results in a counterintuitive experience. For instance, let's say that you want to 'prepend' some element into another element:

```dart
// prepends element0 into element1
final element0 = querySelector('#element0_id');
final element1 = querySelector('#element1_id');
if (element1.hasChildNodes() > 0) {
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
