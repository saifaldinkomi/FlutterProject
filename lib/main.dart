import 'package:flutter/material.dart';
import 'package:projectfeeds/LoginPage.dart';
// import 'package:projectfeeds/views/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:projectfeeds/view_models/login_viewmodel.dart';
// import 'package:provider/provider.dart'; // Add this import
// import 'package:projectfeeds/views/login_page.dart'; // Ensure correct import path
// // import 'package:projectfeeds/viewmodels/login_view_model.dart'; // Ensure you have this file

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => LoginViewModel()), // Add your provider here
//       ],
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         debugShowCheckedModeBanner: false,
//         home: LoginPage(),
//       ),
//     );
//   }
// }
