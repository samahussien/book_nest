import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  final List<Type> _emittedStates = []; 

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    
    _emittedStates.add(change.nextState.runtimeType);

    log("🔥 State emitted: ${change.nextState.runtimeType}");
  }

  bool wasStateEmitted(Type stateType) {
    return _emittedStates.contains(stateType);
  }
}