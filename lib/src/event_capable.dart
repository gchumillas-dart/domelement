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
      List<dynamic> params1 = [event];
      if (event is CustomEvent) {
        params1.add(event.detail);
      }

      // parameters
      List<dynamic> params2 = [];
      ClosureMirror mirror = reflect(handler);
      List<ParameterMirror> handlerParams = mirror.function.parameters;
      int numParams = handlerParams.length;
      for (int i = 0; i < numParams; i++) {
        if (!(i < params1.length)) {
          throw new RangeError('The listener has to many parameters');
        }

        // checks the paramter type
        ParameterMirror handlerParam = handlerParams[i];
        TypeMirror paramType = reflectType(params1[i].runtimeType);
        if (params1[i] != null && !paramType.isSubtypeOf(handlerParam.type)) {
          throw new ArgumentError(
              '${paramType.reflectedType} is not a subtype of ' +
                  '${handlerParam.type.reflectedType}');
        }

        params2.add(params1[i]);
      }

      Function.apply(handler, params2);
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
