import 'package:flutter/material.dart';
import 'package:shop_now_backend/common/common_button.dart';
import 'package:shop_now_backend/common/common_textfield.dart';
import 'package:shop_now_backend/constant/my_theme.dart';
import 'package:shop_now_backend/feature/auth/presentation/sign_in_page.dart';
import 'package:shop_now_backend/feature/auth/repository/auth_repository.dart';
import 'package:shop_now_backend/feature/home/home_page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthRepository();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
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
              "Signup",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 50),
            CommonTextField(
              hintText: "Enter Name",
              label: Text("Name"),
              controller: _name,
            ),
            const SizedBox(height: 20),
            CommonTextField(
              hintText: "Enter Email",
              label: Text("Email"),
              controller: _email,
            ),
            const SizedBox(height: 20),
            CommonTextField(
              hintText: "Enter Password",
              label: Text("Password"),
              // isPassword: true,
              controller: _password,
            ),
            const SizedBox(height: 30),
            CommonButton(
              child: Text("Sign Up"),
              bgColor: MyTheme.purpleShade1,
              onSubmit: _signup,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                InkWell(
                  onTap: () => goToLogin(context),
                  child: const Text(
                    "Login",
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

  goToLogin(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignInPage()),
  );

  goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
  );

  _signup() async {
    final user = await _auth.createUserWithEmailAndPassword(
      _email.text,
      _password.text,
    );
    if (user != null) {
      goToHome(context);
    }
  }
}
