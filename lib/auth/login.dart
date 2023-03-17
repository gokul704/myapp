import 'package:flutter/material.dart';
import 'package:myapp/auth/login.state.dart';
import 'package:myapp/auth/splash_screen.dart';
import 'package:provider/provider.dart';

class HCNLoginPage extends StatefulWidget {
  HCNLoginPage({Key? key, this.title = 'Healthcare Now'}) : super(key: key);

  final String title;

  @override
  _HCNLoginPageState createState() => _HCNLoginPageState();
}

class _HCNLoginPageState extends State<HCNLoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginState loginState = LoginState();
  bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;

    //uncomment below method
    // secureScreen();
  }

  @override
  Widget build(BuildContext context) {
    // var colr = Color(0xff6dd5ed);
    return Scaffold(
        // backgroundColor: colr,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.blue,
        ),
        body: ChangeNotifierProvider<LoginState>(
          create: (_) => loginState,
          child: Container(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   colors: [Colors.blue, Colors.red, Colors.green],
            // )),
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 80, 0, 20),
                child: Form(
                  key: this.formKey,
                  child: ListView(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Image.asset('assets/images/logo.png')),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 20),
                          )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: this.nameController,
                          validator: this.loginState.validateEmail,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          obscureText: !_passwordVisible,
                          controller: passwordController,
                          validator: this.loginState.validatePassword,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              )),
                        ),
                      ),
                      Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                          child: Consumer<LoginState>(
                            builder: (_, loginState, __) => ElevatedButton(
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(color: Colors.white)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                              ),
                              child: Text('Login'),
                              onPressed: () async {
                                if (this.formKey.currentState!.validate()) {
                                  if (await this.loginState.login(
                                      this.nameController.text,
                                      this.passwordController.text)) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SplashScreen()));
                                  }
                                }
                              },
                            ),
                          )),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          foregroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                        ),
                        child: Text('Forgot Password'),
                      ),
                      Container(
                          child: Row(
                        children: <Widget>[
                          Text('Does not have account?'),
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue),
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {},
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ))
                    ],
                  ),
                )),
          ),
        ));
  }
}
