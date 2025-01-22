import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class VerifyCodeEvent extends AuthEvent {
  final String code;

  VerifyCodeEvent(this.code);

  @override
  List<Object?> get props => [code];
}
