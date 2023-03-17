import 'package:flutter/material.dart';

import 'input_container.dart';

class RoundedPasswordInput extends StatefulWidget {
  const RoundedPasswordInput({Key? key}) : super(key: key);

  @override
  State<RoundedPasswordInput> createState() => RoundedPasswordInputState();
}

class RoundedPasswordInputState extends State<RoundedPasswordInput> {
  final String hint = "Enter Password";
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    return InputContainer(
        child: TextField(
            controller: passwordController,
            cursorColor: Colors.blue,
            obscureText: _obscureText,
            decoration: InputDecoration(
                icon: Icon(Icons.lock, color: Colors.blue),
                hintText: hint,
                border: InputBorder.none,
                suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    }))));
  }
}

// class RoundedPasswordInput extends StatefulWidget {
  
//   RoundedPasswordInput({Key? key, required this.hint}) : super(key: key);

//   final String hint;
//   bool _obscureText = true;

//   @override
//   void initState() {
//     _obscureText = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InputContainer(
//         child: TextField(
//             cursorColor: HcnPrimaryColor,
//             obscureText: _obscureText,
//             decoration: InputDecoration(
//                 icon: Icon(Icons.lock, color: HcnPrimaryColor),
//                 hintText: hint,
//                 border: InputBorder.none,
//                 suffixIcon: IconButton(
//                     icon: Icon(
//                       // Based on passwordVisible state choose the icon
//                       _obscureText ? Icons.visibility : Icons.visibility_off,
//                       color: Theme.of(context).primaryColorDark,
//                     ),
//                     onPressed: () {
//                       // Update the state i.e. toogle the state of passwordVisible variable

//                       _obscureText = !_obscureText;
//                     }))));
//   }
  
 
//  //Your code here

// }
