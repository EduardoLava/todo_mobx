import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/store/login_store.dart';
import 'package:todomobx/widgets/custom_icon_button.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

import 'list_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  LoginStore _loginStore;

  ReactionDisposer disposer;

  @override
  Widget build(BuildContext context) {




    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Observer(builder: (_){
                        return CustomTextField(
                          hint: 'E-mail',
                          prefix: Icon(Icons.account_circle),
                          textInputType: TextInputType.emailAddress,
                          onChanged: _loginStore.setEmail,
                          enabled: !_loginStore.loading,
                        );
                      },
                    ),
                    const SizedBox(height: 16,),
                    Observer(builder: (_){
                      return CustomTextField(
                        hint: 'Senha',
                        prefix: Icon(Icons.lock),
                        obscure: _loginStore.passwordIsObscure,
                        onChanged: _loginStore.setPassword,
                        enabled: !_loginStore.loading,
                        suffix: CustomIconButton(
                          radius: 32,
                          iconData: _loginStore.passwordIsObscure ? Icons.visibility : Icons.visibility_off,
                          onTap: _loginStore.changePasswordIsObscure,
                        ),
                      );
                    }),
                    const SizedBox(height: 16,),
                    Observer(
                      builder: (_){
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: (
                                _loginStore.loading ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                )
                            :
                                Text('Login')
                            ),
                            color: Theme.of(context).primaryColor,
                            disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                            textColor: Colors.white,
                            onPressed: _loginStore.loginPressed,

                          ),
                        );
                      },
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

   /* autorun((_){
      if(_loginStore.loggedIn){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)=>ListScreen())
        );
      }

    });*/

   _loginStore = Provider.of<LoginStore>(context);

    /**
     * executa somente quando o valor for alterado
     */
   disposer = reaction(
     (_)=> _loginStore.loggedIn,
     (loggedIn){
       if(loggedIn){
         Navigator.of(context).pushReplacement(
             MaterialPageRoute(builder: (context)=>ListScreen())
         );
       }
     }
   );

  }

  @override
  void dispose() {
    this.disposer();
    super.dispose();
  }

}
