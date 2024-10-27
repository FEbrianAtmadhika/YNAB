part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  // Initial state when no authentication is active
}

class AuthLoading extends AuthState {
  // State for loading actions (login, logout, etc.)
}

class AuthSuccess extends AuthState {
  final AuthModel user;
  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthFailed extends AuthState {
  final String message;
  const AuthFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthAddTransactionSuccess extends AuthState {}

class AuthAddTransactionFailed extends AuthState {
  final String message;
  const AuthAddTransactionFailed(this.message);

  @override
  List<Object?> get props => [message];
}
