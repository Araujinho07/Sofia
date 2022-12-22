import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



import 'Entrar.dart';
import 'chegagem.dart';

class CriarConta extends StatefulWidget {
  const CriarConta({Key? key}) : super(key: key);

  @override
  State<CriarConta> createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> {
  
   final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _firebaseAuth = FirebaseAuth.instance;
    final _nameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const SizedBox(height: 15),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Nome')
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(controller: _emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('E-mail')
            ),),
            const SizedBox(height: 15),
          TextFormField(controller: _passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Senha')
            ),),
            const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
            onPressed: (){
              
              cadastrar();

          }, child: const Text('Cadastrar'))
        ],
      )
    );
  }

  cadastrar() async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
      if (userCredential !=null) {
        userCredential.user!.updateDisplayName(_nameController.text);
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => const Checagem())), (route) => false);
      }
    }on FirebaseAuthException catch (e){
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Use uma senha mais forte'),
            backgroundColor: Colors.redAccent,),
          );
      }else if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Este e-mail já esta em uso'),
            backgroundColor: Colors.redAccent,),
          );
      }
    }

    
    
  }
}