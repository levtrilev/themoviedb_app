import 'package:flutter/material.dart';

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({Key? key}) : super(key: key);

  @override
  _ResetPasswordWidgetState createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TMDB',
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Назад'),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }
}
