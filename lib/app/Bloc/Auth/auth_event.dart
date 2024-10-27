part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthGetCurrent extends AuthEvent {
  // Event for auto-login (retrieve credentials from secure storage)
}

class AuthLogin extends AuthEvent {
  final SignInFormModel data;
  const AuthLogin(this.data);

  @override
  List<Object?> get props => [data];
}

class AuthLogout extends AuthEvent {
  final AuthModel data;
  const AuthLogout(this.data);

  @override
  List<Object> get props => [data];
}

class AuthAddTransaction extends AuthEvent {
  final AuthModel user;
  final AddTransactionModel data;

  const AuthAddTransaction(this.user, this.data);

  @override
  List<Object> get props => [user, data];
}
