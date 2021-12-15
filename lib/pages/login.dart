import 'package:flutter/material.dart';
import 'package:note_app/controller/google_auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Assets/images/cover.png"),
                  ),
                )),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                child: Text(
                  "Create and Manage your Notes",
                  style: TextStyle(
                    fontSize: 35.0,
                    fontFamily: "lato",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: ElevatedButton(
                  onPressed: (){
                    signInWithGoogle(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Continue With Google",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                        ),
                      ),
                      const SizedBox(
                        width: 2.0
                      ),
                      Image.asset('Assets/images/google.png', height: 36),
                    ],
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
