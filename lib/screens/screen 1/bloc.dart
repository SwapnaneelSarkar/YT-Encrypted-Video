import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<VerifyCodeEvent>(_onVerifyCode);
  }

  Future<void> _onVerifyCode(
    VerifyCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    print('Event Received: ${event.code}'); // Debug log for received event
    emit(AuthLoading());
    print('State Emitted: AuthLoading'); // Debug log for loading state

    await Future.delayed(Duration(seconds: 2)); // Simulate network request

    // Replace with actual backend validation logic
    if (event.code == "1234") {
      print('AuthSuccess for code: ${event.code}'); // Debug log for success
      emit(AuthSuccess());
    } else {
      print('AuthFailure for code: ${event.code}'); // Debug log for failure
      emit(AuthFailure());
    }
  }
}
