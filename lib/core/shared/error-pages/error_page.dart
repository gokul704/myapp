import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorPage extends StatelessWidget {
  final String title;
  final String? description;
  final String assetUrl;
  final bool isButtonRequired;
  final String? buttonTitle;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onClose;

  ErrorPage({
    required this.title,
    required this.assetUrl,
    this.onButtonPressed,
    this.buttonTitle,
    this.isButtonRequired = true,
    this.description,
    this.onClose,
  }) {
    assert(this.isButtonRequired ? this.onButtonPressed != null && this.buttonTitle != null : true, 'button title and action cannot be null when is button is set true');
  }

  ErrorPage.sessionExpired({
    this.title = 'Session Expired',
    this.description = 'Looks like your session has been expired',
    this.assetUrl = 'assets/svg/access_denies.svg',
    this.isButtonRequired = true,
    this.buttonTitle = 'Login',
    this.onButtonPressed,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //  This acts as a callback when the modal is being closed.
        // You can execute anything needed.
        if (this.onClose != null) this.onClose!();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(this.title)),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            _getImage(),
            _getTitle(),
            if (this.description != null) _getDescrption(),
            if (this.isButtonRequired) _getActionButton(),
          ]),
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Container(
      margin: _margin,
      child: Text(this.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }

  Widget _getDescrption() {
    return Container(
      margin: _margin,
      child: Text(this.description!, style: TextStyle(color: Colors.black54)),
    );
  }

  Widget _getActionButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 5))),
        onPressed: this.onButtonPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(this.buttonTitle!, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _getImage() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: SvgPicture.asset(this.assetUrl, height: 150, width: 150),
    );
  }

  EdgeInsetsGeometry get _margin => EdgeInsets.only(top: 10);
}
