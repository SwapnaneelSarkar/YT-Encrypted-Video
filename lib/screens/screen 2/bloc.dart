import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';

class SecondPageBloc extends Bloc<SecondPageEvent, SecondPageState> {
  SecondPageBloc() : super(VideoLoadingState());

  @override
  Stream<SecondPageState> mapEventToState(SecondPageEvent event) async* {
    if (event is LoadVideoEvent) {
      try {
        // Simulate a delay for loading
        await Future.delayed(Duration(seconds: 2));
        yield VideoLoadedState();
      } catch (e) {
        yield VideoErrorState("Failed to load video");
      }
    }
  }
}
