part of domelement;

abstract class AttributeCapable {
  Map<String, String> get attr => nativeElement.attributes;
  Map<String, String> get data => nativeElement.dataset;
  Element get nativeElement;
}
