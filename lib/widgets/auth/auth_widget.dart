import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/auth/auth_model.dart';
// import 'package:themoviedb/widgets/main_screen/main_screen_widget.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login to your account')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 10),
            ),
            SizedBox(
              height: 12,
            ),
            AuthForm(),
            Divider(
              thickness: 2,
            ),
            Text(
              'Преимущества членства',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            Text(
              'Создание учётной записи свободно и просто. Заполните форму ниже, чтобы начать.',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            GreetingRow(
              text:
                  'Find something to watch on your subscribed streaming services',
            ),
            GreetingRow(
              text: 'Журналировать отслеживаемые фильмы и телепередачи',
            ),
            GreetingRow(
              text:
                  'Отслеживать избранные фильмы и сериалы и получать на их основе рекомендации',
            ),
            GreetingRow(
              text: 'Создание и ведение персонального списка отслеживания',
            ),
            GreetingRow(
              text: 'Создание собственных смешанных списков (фильмы и ТВ)',
            ),
            GreetingRow(
              text: 'Участие в обсуждениях фильмов и телепередач',
            ),
            GreetingRow(
              text: 'Внесение и улучшение информации в нашей базе данных',
            ),
          ],
        ),
      ),
    );
  }
}

class AuthForm extends StatelessWidget {
  const AuthForm({Key? key}) : super(key: key);

  void _reset_password() {
    // Navigator.of(context).pushNamed('/reset_password');
  }

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.read(context)?.model;
    // final _buttonStyle = ButtonStyle(
    //     textStyle: MaterialStateProperty.all(
    //   TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    // ));
    return Column(children: [
      ...[
        const _ErrorMessageWidget(),
        SizedBox(
          height: 8,
        )
      ],
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 6),
        child: TextField(
          obscureText: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Username',
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            isCollapsed: true,
          ),
          controller: model?.loginTextController, // _loginTextController,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            isCollapsed: true,
          ),
          controller: model?.passwordTextController, // _passwordTextController,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Text(
            //     'Нажимая кнопку «Зарегистрироваться» ниже, я подтверждаю, что я прочитал и согласен с Условиями использования TMDb и Политикой конфиденциальности.'),
            SizedBox(height: 25),
            Row(
              children: [
                _AuthButtonWidget(),
                SizedBox(width: 16),
                TextButton(
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  )),
                  child: Text('Reset password'),
                  onPressed: _reset_password,
                )
              ],
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    ]);
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.watch(context)?.model;
    final onPressed =
        model?.canStartAuth == true ? () => model?.auth(context) : null;
        final child = model?.isAuthProgress == true ? CircularProgressIndicator() : Text('Login');
    return ElevatedButton(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
        TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      )),
      child: child,
      onPressed: onPressed,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = AuthProvider.watch(context)?.model.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        errorMessage,
        style: TextStyle(
          color: Colors.red,
          fontSize: 18,
        ),
      ),
    );
  }
}

class GreetingRow extends StatelessWidget {
  final String text;
  const GreetingRow({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 32.0),
            child: Icon(Icons.check),
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
              child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
            ),
          )),
        ],
      ),
    );
  }
}
