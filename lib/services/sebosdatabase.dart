import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/models/sebo.dart';

class SebosDataBase {

      static Future<List<Sebo>> sabedoria() async {
          List<Sebo> lista = [];
          final collection = await FirebaseFirestore.instance.collection("sebos").get();
          for (var document in collection.docs) {
            List<String> horarios = [
              for (final horario in document.data()["Horários"]!)
                horario as String,
            ];
            final sebo = 
            Sebo(document.id, document.data()["Endereço"]! as String, horarios);
            lista.add(sebo);
          }
          return lista;
      }
}