import 'package:flutter/material.dart';

class OverlayLoader {
  BuildContext? context;
  Future<void> startLoading(BuildContext context, {bool isDismissible = false}) async {
    this.context = context;
    return showDialog(context: context, builder: (_) => HCNOverlayLoader(isDismissible: isDismissible));
  }

  void stopLoading() {
    if (this.context != null && Navigator.of(context!).canPop()) {
      Navigator.of(context!).pop();
      this.context = null;
    }
  }
}

class HCNOverlayLoader extends StatelessWidget {
  final bool isDismissible;

  const HCNOverlayLoader({Key? key, required this.isDismissible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => this.isDismissible,
      child: Container(
        color: Colors.black26,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
