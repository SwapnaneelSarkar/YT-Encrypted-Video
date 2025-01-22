import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';

class SecondPageBloc extends Bloc<SecondPageEvent, SecondPageState> {
  SecondPageBloc() : super(VideoLoadingState()) {
    // Register the handler for LoadVideoEvent
    on<LoadVideoEvent>((event, emit) async {
      emit(VideoLoadingState());
      try {
        // Simulate a loading delay
        await Future.delayed(Duration(seconds: 2));
        emit(VideoLoadedState());
      } catch (e) {
        emit(VideoErrorState("Failed to load video"));
      }
    });
  }
}
