import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todoflutter/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


 @override
  void initState() {
    super.initState();

   Timer(const Duration(seconds: 4), () {
   
      Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => 
       const HomePage( )),
     );
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
        backgroundColor: Colors.white,
        body:Center(
         child: Center(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
              Container(
           

                height: 100,
                width: 100,
                color: Colors.transparent,
                child: Image.network('https://static-00.iconduck.com/assets.00/todo-icon-2048x2048-pij2pwiy.png')),
               Container(
                child: Text('TO DO LIST', 
                style: TextStyle(fontSize: 24,
                fontWeight: FontWeight.bold),),
               ),
             ],
           ),
         ),
        ),
    );
  }
}