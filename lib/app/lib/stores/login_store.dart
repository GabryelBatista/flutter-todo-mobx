import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  _LoginStoreBase() {
    autorun(_) {
      print(email);
      print(password);
    }
  }

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool passwordVisible = false;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  void togglePasswordVisibility() => passwordVisible = !passwordVisible;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  Future login() async {
    loading = true;

    await Future.delayed(const Duration(seconds: 2));

    loading = false;
    loggedIn = true;

    email = "";
    password = "";
  }

  @action
  void logout() {
    loggedIn = false;
  }

  @computed
  dynamic get loginPressed {
    return (isEmailValid && isPasswordValid && !loading) ? login : null;
  }

  @computed
  bool get isEmailValid => email.length > 6;

  @computed
  bool get isPasswordValid => password.length > 6;
}
