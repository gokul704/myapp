import 'package:flutter/material.dart';
import 'package:myapp/auth/login.state.dart';
import 'package:myapp/auth/login/componets/input_container.dart';
import 'package:myapp/auth/splash_screen.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final LoginState loginState = LoginState();

  bool _obscureText = true;
  Duration animationDuration = Duration(milliseconds: 270);

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double defaultLoginSize = size.height - (size.height * 0.2);

    return AnimatedOpacity(
        opacity: 1.0,
        duration: animationDuration * 4,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: size.width,
            height: defaultLoginSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 150),
                  // SvgPicture.asset('assets/svg/new/login.svg'),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                    width: 300,
                  ),
                  SizedBox(height: 10),
                  InputContainer(
                      child: TextField(
                    controller: usernameController,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        icon: Icon(Icons.mail, color: Colors.blue),
                        hintText: " Username",
                        border: InputBorder.none),
                  )),
                  InputContainer(
                      child: TextField(
                          controller: passwordController,
                          cursorColor: Colors.blue,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock, color: Colors.blue),
                              hintText: "Password",
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  })))),
                  // RoundedPasswordInput(),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      print(usernameController.text);
                      print(passwordController.text);
                      if (await this.loginState.login(
                          this.usernameController.text,
                          this.passwordController.text)) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SplashScreen()));
                      }
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: Text(
                        "LOGIN  ",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  // RoundedButton(title: 'LOGIN'),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ));
  }
}

     

// class LoginForm extends StatelessWidget {
//   const LoginForm({
//     Key? key,
//     required this.isLogin,
//     required this.animationDuration,
//     required this.size,
//     required this.defaultLoginSize,
//   }) : super(key: key);

//   final bool isLogin;
//   final Duration animationDuration;
//   final Size size;
//   final double defaultLoginSize;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedOpacity(
//       opacity: isLogin ? 1.0 : 0.0,
//       duration: animationDuration * 4,
//       child: Align(
//         alignment: Alignment.center,
//         child: Container(
//           width: size.width,
//           height: defaultLoginSize,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 150),
//                 // SvgPicture.asset('assets/svg/new/login.svg'),
//                 Image.asset(
//                   'assets/images/logo.png',
//                   height: 100,
//                   width: 300,
//                 ),
//                 SizedBox(height: 10),
//                 InputContainer(
//                     child: TextField(
//                   cursorColor: HcnPrimaryColor,
//                   decoration: InputDecoration(
//                       icon: Icon(Icons.mail, color: HcnPrimaryColor),
//                       hintText: "ENTER USERNAME",
//                       border: InputBorder.none),
//                 )),
//                 RoundedInput(icon: Icons.mail, hint: 'Username'),
//                 RoundedPasswordInput(),
//                 SizedBox(height: 10),
//                 RoundedButton(title: 'LOGIN'),
//                 SizedBox(height: 10),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
