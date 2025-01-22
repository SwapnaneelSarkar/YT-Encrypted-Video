abstract class SecondPageState {}

class VideoLoadingState extends SecondPageState {}

class VideoLoadedState extends SecondPageState {}

class VideoErrorState extends SecondPageState {
  final String errorMessage;

  VideoErrorState(this.errorMessage);
}
