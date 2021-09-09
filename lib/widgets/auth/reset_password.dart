import 'package:flutter/material.dart';
import 'package:themoviedb/images.dart';

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
        title: const Text(
          'TMDB',
        ),
      ),
      body: const Center(
        child: InputFormWidget(),
      ),
    );
  }
}

class InputFormWidget extends StatelessWidget {
  const InputFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        children: [
          TextField(
            enabled: true,
            decoration: InputDecoration(
              //icon: Icon(Icons.warning),
              labelText: 'Your Phone Number Here',
              hintText: '9161234567',
              helperText: 'OK, you have to tell me YOUR Phone Number!',
              helperMaxLines: 1,
              //errorText: 'Your input value is not correct!',
              errorMaxLines: 2,
              prefixIcon: const Icon(Icons.phone),
              prefixText: '+ 7',
              //floatingLabelBehavior: FloatingLabelBehavior.always,
              //isCollapsed: true,
              // isDense: true,
              // contentPadding: EdgeInsets.all(16),
              // counter: Text('3/10'),
              filled: true,
              fillColor: Colors.green[100],
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),
            ),
          ),
          ElevatedButton(
            child: const Text('Назад'),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
          ElevatedButton(
            child: const Text('Json test'),
            onPressed: () {
              Navigator.of(context).pushNamed('/json_test');
            },
          ),
          const Image(image: AppImages.resetPassword),
        ],
      ),
    );
  }
}
