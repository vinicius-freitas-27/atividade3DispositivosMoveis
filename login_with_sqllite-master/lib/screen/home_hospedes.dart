import 'package:flutter/material.dart';
import 'package:login_with_sqllite/model/hospede_model.dart';
import 'package:sqflite/sqflite.dart';

import '../common/routes/view_routes.dart';
import 'package:login_with_sqllite/external/database/db_sql_lite.dart';

class HomeHospedes extends StatefulWidget {

  const HomeHospedes({super.key});

  @override
  _HomeHospedesState createState() => _HomeHospedesState();
}

class _HomeHospedesState extends State<HomeHospedes> {

  final db = SqlLiteDb();
  List<HospedeModel> hospedes = [];

  _listarHospedes() async{
    List<HospedeModel> hosp = await db.getHospedes();
    setState(() => hospedes = hosp);
  }

  @override
  initState() {
    super.initState();
    _listarHospedes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Sistema de Gerenciamento de Hospedes'),
      ),

      body: SafeArea(
        child: Column(
          children: <Widget>[

            Expanded (

              child: ListView.builder(

                itemCount: hospedes.length,
                itemBuilder: (BuildContext context, int index) {

                  return ListTile(

                    leading: Icon(Icons.account_circle_sharp) ,

                    title: Text(hospedes[index].hospedeNome),

                    subtitle: Text("De " + hospedes[index].hospedeLocalidade +
                        ", Endereco: " + hospedes[index].hospedeEndereco +
                        ", Idade: " + hospedes[index].getIdade().toString()
                    ),

                    onTap: (){

                      db.deleteHospede(hospedes[index].hospedeCPF);
                      Navigator.pushNamedAndRemoveUntil(
                          context, RoutesApp.homeHospedes, (Route<dynamic> route) => false);

                    },
                  );

                },

              )
            ),
            ElevatedButton(
              child: new Text("Cadastrar Hospede"),

              onPressed: (){
                Navigator.pushNamed(
                  context,
                  RoutesApp.cadastroHospedes,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent , // Background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
