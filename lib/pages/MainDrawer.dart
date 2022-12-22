import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_3/pages/Entrar.dart';




class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<StatefulWidget> createState() => _MainDrawerState();
  
}

class _MainDrawerState extends State<StatefulWidget>{


  final _firebaseAuth = FirebaseAuth.instance;
  String nome = '';
  String email = '';
  
  @override
  initState(){
    super.initState();
    pegarusuario();
  }

  @override
  Widget build(BuildContext context){
    
    return Drawer(
 
  child: ListView(
 
    padding: EdgeInsets.zero,
    children: [
      UserAccountsDrawerHeader(accountName: Text(nome), accountEmail: Text(email), decoration: const BoxDecoration(
          color: Colors.black,
        ),),
  
      ListTile(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Sair'),
        onTap: () {
          sair();
        },
      ),
    ],
  ),
);
  }

  pegarusuario() async{
    User? usuario = await _firebaseAuth.currentUser;
    if (usuario !=null) {
      setState(() {
        nome = usuario.displayName!;
        email = usuario.email!;
      });
    }
  }

 sair() async{
  await _firebaseAuth.signOut().then((user) => Navigator.pushReplacement<void, void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => const Entrar(),
    ),
  ));
 }
}