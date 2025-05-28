import 'package:flutter/material.dart';
import 'package:shop_now_backend/common/common_button.dart';
import 'package:shop_now_backend/common/common_textfield.dart';
import 'package:shop_now_backend/constant/my_theme.dart';
import 'package:shop_now_backend/feature/auth/presentation/sign_up_page.dart';
import 'package:shop_now_backend/feature/auth/repository/auth_repository.dart';
import 'package:shop_now_backend/feature/home/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _auth = AuthRepository();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              "Login",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 50),
            CommonTextField(
              hintText: "Enter Email",
              label: Text("Email"),
              controller: _email,
            ),
            const SizedBox(height: 20),
            CommonTextField(
              hintText: "Enter Password",
              label: Text("Password"),
              controller: _password,
            ),
            const SizedBox(height: 30),
            CommonButton(
              child: const Text("Login"),
              onSubmit: _login,
              bgColor: MyTheme.purpleShade1,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                InkWell(
                  onTap: () => goToSignup(context),
                  child: const Text(
                    "Signup",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  goToSignup(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignupScreen()),
  );

  goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
  );

  _login() async {
    final user = await _auth.loginUserWithEmailAndPassword(
      _email.text,
      _password.text,
    );

    if (user != null) {
      goToHome(context);
    }
  }
}
