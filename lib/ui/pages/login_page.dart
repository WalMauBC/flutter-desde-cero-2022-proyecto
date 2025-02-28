import "package:flutter/material.dart";
import 'package:flutter_2022_proyecto/ui/pages/email_login_page.dart';
import 'package:flutter_2022_proyecto/ui/pages/register_page.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/EDteam.png", width: 150, height: 150),
            Text(
              "Bienvenido a mi aplicacion",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.google,
                  onPressed: () {},
                ),
                SizedBox(height: 16),
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.facebook,
                  onPressed: () {},
                ),
                SizedBox(height: 16),
                GestureDetector(
                  child: Text(
                    "Iniciar sesion con correo",
                    style: TextStyle(
                      color: Colors.blue[700],
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmailLoginPage()),
                    );
                  },
                ),
                Text("o"),
                GestureDetector(
                  child: Text(
                    "Crear cuenta",
                    style: TextStyle(
                      color: Colors.blue[700],
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
