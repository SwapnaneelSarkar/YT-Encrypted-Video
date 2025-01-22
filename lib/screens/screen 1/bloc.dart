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
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 2)); // Simulate network request

    // Replace with actual backend validation logic
    if (event.code == "1234") {
      // Example code for validation
      emit(AuthSuccess());
    } else {
      emit(AuthFailure());
    }
  }
}
