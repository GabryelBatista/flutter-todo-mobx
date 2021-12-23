import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_todo_mobx/app/lib/screens/list_screen.dart';
import 'package:flutter_todo_mobx/app/lib/stores/login_store.dart';
import 'package:flutter_todo_mobx/app/lib/widgets/custom_text_field.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginStore loginStore;

  late ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loginStore = Provider.of<LoginStore>(context);

    disposer = reaction((_) => loginStore.loggedIn, (loggedIn) {
      print(loggedIn);
      if (loginStore.loggedIn) {
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ListScreen(),
        ),
      );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
          child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.325,
            child: Column(
              children: [
                Observer(
                  builder: (_) => CustomTextField(
                    hint: 'Email',
                    enable: !loginStore.loading,
                    preffix: Icons.person,
                    suffix: null,
                    changed: loginStore.setEmail,
                  ),
                ),
                Observer(
                  builder: (_) => CustomTextField(
                    hint: 'Senha',
                    enable: !loginStore.loading,
                    suffix: InkWell(
                      child: loginStore.passwordVisible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onTap: loginStore.togglePasswordVisibility,
                    ),
                    preffix: Icons.lock,
                    changed: loginStore.setPassword,
                    obscure: !loginStore.passwordVisible,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Observer(
                  builder: (_) => Container(
                    height: MediaQuery.of(context).size.height * 0.075,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      onPressed: loginStore.loginPressed,
                      child: loginStore.loading
                          ? Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    dispose();
    super.dispose();
  }
}
