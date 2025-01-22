import 'package:equatable/equatable.dart';

abstract class SecondPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class VideoLoadingState extends SecondPageState {}

class VideoLoadedState extends SecondPageState {}

class VideoErrorState extends SecondPageState {
  final String errorMessage;

  VideoErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
