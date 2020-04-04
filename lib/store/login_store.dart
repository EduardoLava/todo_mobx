
import 'dart:ffi';

import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  _LoginStore(){
    autorun((_){
      print("email "+email);
      print("password "+password);
//      print("isFormValid "+isFormValid.toString());
      print("passwordIsObscure "+passwordIsObscure.toString());
    });
  }

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool passwordIsObscure = true;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  void setEmail(String email) => this.email = email;

  @action
  void setPassword(String password) => this.password = password;

  @action
  void changePasswordIsObscure() => passwordIsObscure = !passwordIsObscure;

  @action
  Future<void> login() async {
    loading = true;

    await Future.delayed(Duration(seconds: 2));
    // processar os dados

    loading = false;
    loggedIn = true;

  }

  @action
  void logout(){

    email = "";
    password = "";

    loggedIn = false;
  }

  @computed
  bool get isEmailValid => RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(email);

  @computed
  bool get isPasswordValid => password.length > 6;

//  @computed
//  bool get isFormValid => isEmailValid && isPasswordValid;

  @computed
  Function get loginPressed =>
      (isEmailValid && isPasswordValid && !loading) ? login : null;

}