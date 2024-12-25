// import 'package:flutter/material.dart';
// import 'package:projectfeeds/view_models/login_viewmodel.dart';
// import 'package:provider/provider.dart';
// import 'package:projectfeeds/models/login_model.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();

//     return ChangeNotifierProvider(
//       create: (_) => LoginViewModel(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Login"),
//           centerTitle: true,
//         ),
//         body: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Form(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Welcome Back!",
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       "Please login to your account",
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                     const SizedBox(height: 30),
//                     TextFormField(
//                       controller: emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         labelText: "Email",
//                         prefixIcon: const Icon(Icons.email),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextFormField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         prefixIcon: const Icon(Icons.lock),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {
//                           // Implement forgot password functionality
//                         },
//                         child: const Text("Forgot Password?"),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Consumer<LoginViewModel>(
//                       builder: (context, viewModel, child) {
//                         return viewModel.isLoading
//                             ? const Center(
//                                 child: CircularProgressIndicator(),
//                               )
//                             : ElevatedButton(
//                                 onPressed: () {
//                                   final loginData = LoginModel(
//                                     email: emailController.text,
//                                     password: passwordController.text,
//                                   );
//                                   viewModel.login(loginData, context);
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   minimumSize: const Size(double.infinity, 50),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   "Login",
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                               );
//                       },
//                     ),
//                     const SizedBox(height: 30),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Don't have an account?"),
//                         TextButton(
//                           onPressed: () {
//                             // Navigate to the signup page
//                           },
//                           child: const Text("Sign Up"),
//                         ),
//                       ],
//                     ),
//                     Consumer<LoginViewModel>(
//                       builder: (context, viewModel, child) {
//                         if (viewModel.errorMessage != null) {
//                           return Padding(
//                             padding: const EdgeInsets.only(top: 16.0),
//                             child: Text(
//                               viewModel.errorMessage!,
//                               style: const TextStyle(
//                                 color: Colors.red,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           );
//                         }
//                         return const SizedBox.shrink();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:projectfeeds/models/login_model.dart';
import 'package:projectfeeds/view_models/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  final LoginViewModel _viewModel = LoginViewModel();

  void _login() async {
    setState(() {
      isLoading = true;
      errorMessage = null; // Clear any previous error message
    });

    final loginData = LoginModel(
      email: emailController.text,
      password: passwordController.text,
    );

    // Call the login method from LoginViewModel
    await _viewModel.login(loginData, context);

    setState(() {
      isLoading = false;
      errorMessage = _viewModel.errorMessage;  // Get the error message from the viewModel
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Please login to your account",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Implement forgot password functionality
                      },
                      child: const Text("Forgot Password?"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          // Navigate to the signup page
                        },
                        child: const Text("Sign Up"),
                      ),
                    ],
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
