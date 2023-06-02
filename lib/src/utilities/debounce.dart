import "dart:async";

class Debounce {
  final Duration _delay;
  final void Function() _callback;
  Timer? _delayTimer;

  Debounce(this._delay, this._callback);

  /// Do not run the callback after the current timer completes.
  ///
  /// You may wish to cancel the debounced function call during a teardown/
  /// cleanup procedure or when changing context.
  void cancel() {
    _delayTimer?.cancel();
  }

  /// Run the callback _once_ after the given delay duration time has passed
  /// uninterrupted since the last time the [Debounce] function was invoked (via
  /// `debouncedFunction()` or `debouncedFunction.call()`).
  ///
  /// Don't forget to [cancel] the debounced function on cleanup, if applicable.
  void call() {
    cancel();
    _delayTimer = Timer(_delay, _callback);
  }
}
