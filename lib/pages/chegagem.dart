import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/pages/Entrar.dart';

class Checagem extends StatefulWidget {
  const Checagem({super.key});
  
  @override
  State<StatefulWidget> createState() => _checagemState();
    
  }

  // ignore: camel_case_types
  class _checagemState extends State<StatefulWidget> {
    

    StreamSubscription? streamSubscription;



    @override
    initState() {
    super.initState();

    streamSubscription = FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
            if (user == null) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const Entrar())));
            }else{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const Home())));
            }

         });
  }

    @override
    void dispose(){
      streamSubscription!.cancel();
      super.dispose();
    }



  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }
  }
  
