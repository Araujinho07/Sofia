import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/Criar_Conta.dart';

import '../main.dart';

class Entrar extends StatefulWidget {
  
    const Entrar({Key? key}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _EntrarState();

}

class _EntrarState extends State<StatefulWidget> {


    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _firebaseAuth = FirebaseAuth.instance;

     @override
     Widget build(BuildContext context){
        return Scaffold(
          appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
          body: ListView(
            children: [
              const SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('E-mail')
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Senha')
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
                onPressed: (){
                login();
              }, child: const Text('Entrar')),
              TextButton(onPressed: (){
                  Navigator.push( context,
                      MaterialPageRoute(builder: (context) => const CriarConta())
                  );
              }, child: const Text('Criar Conta'),
              ),

            ],)
        );
     }

    login() async{
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
      if(userCredential != null){
          // ignore: use_build_context_synchronously
          Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const Home(),
                      ),
                    );
      } 

    }on FirebaseAuthException catch(error){
        if (error.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário não encontrado'),
            backgroundColor: Colors.redAccent,),
          );
        }else if(error.code == 'wrong-password'){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Senha incorreta'),
            backgroundColor: Colors.redAccent,),
          );
        }
    }
  }
  
}

