class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }
  Future<void> _onLoginSubmitted(...) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));

    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      emit(AuthAuthenticated(email: event.email));
    } else {
      emit(AuthError(message: 'Email atau password salah'));
    }
  }

