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

# Install

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
