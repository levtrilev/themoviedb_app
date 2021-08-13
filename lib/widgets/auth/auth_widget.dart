import 'package:flutter/material.dart';
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
        title: Center(child: Text('Преимущества членства')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
            Divider(
              thickness: 2,
            ),
            Text(
              'Зарегистрировать учётную запись',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 10),
              child: Text(
                'Создание учётной записи свободно и просто. Заполните форму ниже, чтобы начать.',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            AuthForm(),
          ],
        ),
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passwordCheckTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  String? _errorText = null;

  void _auth() {
    if (_passwordTextController.text != _passwordCheckTextController.text) {
      _errorText = 'Два варианта пароля не совпадают!';
    } else {
      _errorText = null;
      // final navigator = Navigator.of(context);
      // navigator.push(
      //     MaterialPageRoute<void>(builder: (context) => MainScreenWidget()));
      Navigator.of(context).pushReplacementNamed('/main_screen');
      // Navigator.of(context).pushNamed('/main_screen');
    }
    setState(() {});
  }

  void _reset_password() {
    Navigator.of(context).pushNamed('/reset_password');
  }

  final _buttonStyle = ButtonStyle(
      textStyle: MaterialStateProperty.all(
    TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
  ));
  @override
  Widget build(BuildContext context) {
    //final textFieldDecoration = OwnInputDecoration('Пароль (4 characters minimum)');
    return Column(children: [
      if (_errorText != null) ...[
        Text(
          _errorText!,
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 6),
        child: TextField(
          obscureText: false,
          decoration: OwnInputDecoration('Имя пользователя'),
          controller: _loginTextController,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
        child: TextField(
          obscureText: true,
          decoration: OwnInputDecoration('Пароль (4 characters minimum)'),
          controller: _passwordTextController,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
        child: TextField(
          obscureText: true,
          decoration: OwnInputDecoration('Подтверждение пароля'),
          controller: _passwordCheckTextController,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 6, 24, 25),
        child: TextField(
          obscureText: false,
          decoration: OwnInputDecoration('Эл.почта'),
          controller: _emailTextController,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Text(
                'Нажимая кнопку «Зарегистрироваться» ниже, я подтверждаю, что я прочитал и согласен с Условиями использования TMDb и Политикой конфиденциальности.'),
            SizedBox(height: 25),
            Row(
              children: [
                ElevatedButton(
                  style: _buttonStyle,
                  child: Text('Зарегистрироваться'),
                  onPressed: _auth,
                ),
                SizedBox(width: 16),
                TextButton(
                  style: _buttonStyle,
                  child: Text('Отмена'),
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

  InputDecoration OwnInputDecoration(String label) {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: label,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true,
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
