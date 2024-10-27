import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ynab/app/model/addtransactionmodel.dart';
import 'package:ynab/app/model/authmodel.dart';
import 'package:ynab/app/model/signinmodel.dart';
import 'package:ynab/app/services/authservice.dart';
import 'package:ynab/app/services/securestorageservices.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthGetCurrent) {
        try {
          emit(AuthLoading());
          // Retrieve saved credentials from secure storage
          final SignInFormModel? savedCredentials =
              await SecureStorageServices().getCredentialFromLocal();

          if (savedCredentials != null) {
            // Try to log in using saved credentials
            AuthModel user = await AuthService().login(savedCredentials);
            await SecureStorageServices().storeCredentialToLocal(
                user.accessToken, user.user.email, savedCredentials.password!);
            emit(AuthSuccess(user));
          } else {
            emit(AuthInitial()); // No saved credentials
          }
        } catch (e) {
          emit(AuthFailed("Failed to auto-login: ${e.toString()}"));
        }
      }

      if (event is AuthLogin) {
        try {
          emit(AuthLoading());

          // Attempt to log in with provided credentials
          AuthModel user = await AuthService().login(event.data);

          // Save login credentials for auto-login
          await SecureStorageServices().storeCredentialToLocal(
              user.accessToken, user.user.email, event.data.password!);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed("Login failed: ${e.toString()}"));
        }
      }

      if (event is AuthLogout) {
        try {
          emit(AuthLoading());
          await AuthService().logout();
          emit(AuthInitial());
        } catch (e) {
          print(e.toString());
          emit(AuthFailed(e.toString()));
          emit(AuthSuccess(event.data));
        }
      }

      if (event is AuthAddTransaction) {
        try {
          AuthModel user =
              await AuthService().addTransaction(event.user, event.data);

          emit(AuthAddTransactionSuccess());
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthAddTransactionFailed(e.toString()));
          emit(AuthSuccess(event.user));
        }
      }
    });
  }
}
