import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:myapp/views/home/home.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final auth = LocalAuthentication();
  String authorized = " not authorized";
  bool _canCheckBiometric = false;
  List<BiometricType> _availableBiometric = [];

  Future<void> _authenticate() async {
    bool authenticated = false;
    print(_canCheckBiometric);

    try {
      authenticated = await auth.authenticate(
        authMessages: [],
        localizedReason: "Scan your finger to authenticate",
      );
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      authorized =
          authenticated ? "Authorized success" : "Failed to authenticate";
      print(authorized);
    });
    Widget targetPage = AuthCheck();

    if (authenticated == true || _availableBiometric.length == 0) {
      targetPage = HomePage();
    }
    this._navigateToPage(targetPage);
  }

  void _navigateToPage(Widget targetPage) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => targetPage));
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future _getAvailableBiometric() async {
    try {
      _availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      _availableBiometric = _availableBiometric;
    });
  }

  @override
  void initState() {
    _checkBiometric();
    _getAvailableBiometric();
    _authenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Fingerprint Auth")),
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/logo.png'),
              Container(
                margin: EdgeInsets.symmetric(vertical: 80.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => {
                        _authenticate(),
                      },
                      child: Image.asset(
                        "assets/images/fingerprint.png",
                        width: 120.0,
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        _authenticate(),
                      },
                      child: Text(
                        "Click here to proceed",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        _authenticate(),
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          "Press here for authentication",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, height: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
