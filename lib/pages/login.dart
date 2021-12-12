import 'package:flutter/material.dart';

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
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Text(
                        "Continue With Google",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "lato",
                        ),
                      ),

                      Image.asset('Assets/images/google.png',
                      height: 36),
                    ],
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
