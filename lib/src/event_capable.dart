part of domelement;

abstract class EventCapable {
  Element get nativeElement;

  List<_EventListener> _eventListeners = [];

  void off(String type, Function handler) {
    _eventListeners.where((_EventListener eventListener) {
      if (eventListener.type == type && eventListener.handler == handler) {
        nativeElement.removeEventListener(type, eventListener.listener);
      }
    });
  }

  void on(String type, Function handler) {
    EventListener listener = (Event event) {
      // parameters
      List<dynamic> params = [];
      ClosureMirror mirror = reflect(handler);
      int numParams = mirror.function.parameters.length;
      if (numParams > 0) {
        params.add(event);
      }
      if (numParams > 1 && event is CustomEvent) {
        params.add(event.detail);
      }

      Function.apply(handler, params);
    };
    _eventListeners.add(new _EventListener(type, handler, listener));
    nativeElement.addEventListener(type, listener);
  }

  void trigger(String type, {dynamic data}) {
    nativeElement.dispatchEvent(new CustomEvent(type, detail: data));
  }
}

class _EventListener {
  final String type;
  final Function handler;
  final EventListener listener;
  _EventListener(this.type, this.handler, this.listener);
}
