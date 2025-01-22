import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';

class SecondPageBloc extends Bloc<SecondPageEvent, SecondPageState> {
  SecondPageBloc() : super(VideoLoadingState()) {
    // Register the handler for LoadVideoEvent
    on<LoadVideoEvent>((event, emit) async {
      emit(VideoLoadingState());
      print('State Emitted: VideoLoadingState'); // Debug log for loading state
      try {
        // Simulate a loading delay
        await Future.delayed(Duration(seconds: 2));
        emit(VideoLoadedState());
        print('State Emitted: VideoLoadedState'); // Debug log for loaded state
      } catch (e) {
        emit(VideoErrorState("Failed to load video"));
        print(
            'State Emitted: VideoErrorState, Error: $e'); // Debug log for error state
      }
    });
  }
}
