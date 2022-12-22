import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/MainDrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_3/pages/chegagem.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';


void main() async{

// ...
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    );
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Checagem(),debugShowCheckedModeBanner: false,);
    
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;
 


  @override
  Widget build(BuildContext context) {
    return 
      SafeArea(
      child: Scaffold(
        appBar: AppBar(
    centerTitle: true,
    title: const Text('SOFIA'),
    backgroundColor: Colors.black,
  ),
  drawer: const MainDrawer(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('sebos')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((documents) {
                var avaliacao = documents['Avaliação'];
                return  ListTile(
                  
                  title: Text(documents['Nome']),
                  subtitle: Text('Avaliação: $avaliacao'),
                  trailing: SizedBox(
                    width: 100,
                    
                    child: Row(
                    children: <Widget>[
                      IconButton(onPressed: (){
                         Navigator.push(context, MaterialPageRoute<void>(
  builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(documents['Nome']), centerTitle: true, backgroundColor: Colors.black,),
      body: Center(
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text("Avaliação:", style: TextStyle(color: Colors.grey[800],
  fontWeight: FontWeight.w900,
  fontStyle: FontStyle.italic,
  fontFamily: 'Open Sans',
  fontSize: 15),),
  Text(documents['Avaliação']),
  
          const SizedBox(height: 15),
          Text("WebSite:", style: TextStyle(color: Colors.grey[800],
  fontWeight: FontWeight.w900,
  fontStyle: FontStyle.italic,
  fontFamily: 'Open Sans',
  fontSize: 15),),
  const SizedBox(height: 15),
   ElevatedButton(style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
    onPressed: () async {
              var site = documents['Website'];
              var url = site;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
          }, child: const Text('Ir Para')),
          const SizedBox(height: 15),
          Text("Contato:", style: TextStyle(color: Colors.grey[800],
  fontWeight: FontWeight.w900,
  fontStyle: FontStyle.italic,
  fontFamily: 'Open Sans',
  fontSize: 15),),
  Text(documents['Telefone']),
          const SizedBox(height: 15),
           Text("Endereço:", style: TextStyle(color: Colors.grey[800],
  fontWeight: FontWeight.w900,
  fontStyle: FontStyle.italic,
  fontFamily: 'Open Sans',
  fontSize: 15),),
          Text(documents['Endereço']),
          const SizedBox(height: 15),
          ElevatedButton(style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
            onPressed: () async {
              var latitude = documents['Latitude'];
              var longetude = documents['Longitude'];
              var urlMap =
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longetude";
  if (await canLaunchUrlString(urlMap)) {
    await launchUrlString(urlMap);
  } else {
    throw 'Could not launch Maps';
  }
          }, child: const Text('Ir Para')),
        ],
      )
      )
      );
    
  },
));
                      }, icon: const Icon(Icons.content_paste_search)),
                      ],
                  ),)
                );
              }).toList(),
            );
          },
        ),
      ),
    );
    
  }

 abrirGoogleMaps() async {
  const urlMap =
      "https://www.google.com/maps/search/?api=1&query=-22.9732303,-43.2032649";
  if (await canLaunch(urlMap)) {
    await launch(urlMap);
  } else {
    throw 'Could not launch Maps';
  }
}
  
}

