import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/messages/messages.dart';
import '../common/routes/view_routes.dart';
import '../components/user_login_header.dart';
import '../components/user_text_field.dart';
import '../external/database/db_sql_lite.dart';
import '../model/hospede_model.dart';

class CadastroHospedes extends StatefulWidget {
  const CadastroHospedes({super.key});

  @override
  State<CadastroHospedes> createState() => _CadastroHospedesState();
}

class _CadastroHospedesState extends State<CadastroHospedes> {
  final _formKey = GlobalKey<FormState>();
  final _hospedeCPFController = TextEditingController();
  final _hospedeNomeController = TextEditingController();
  final _hospedeDataNascimentoController = TextEditingController();
  final _hospedeLocalidadeController = TextEditingController();
  final _userEnderecoController = TextEditingController();

  final db = SqlLiteDb();

  @override
  void dispose() {
    _hospedeCPFController.dispose();
    _hospedeNomeController.dispose();
    _hospedeDataNascimentoController.dispose();
    _hospedeLocalidadeController.dispose();
    _userEnderecoController.dispose();
    super.dispose();
  }

  void cadastrarHospede(BuildContext context) async {
    // Retorna TRUE em caso de
    // conteudo valido de todos os campos
    if (_formKey.currentState!.validate()) {
      HospedeModel hospede = HospedeModel(
        hospedeCPF: _hospedeCPFController.text.trim(),
        hospedeNome: _hospedeNomeController.text.trim(),
        hospedeDataNascimento: _hospedeDataNascimentoController.text.trim(),
        hospedeLocalidade: _hospedeLocalidadeController.text.trim(),
        hospedeEndereco: _userEnderecoController.text.trim(),
      );

      db.saveHospede(hospede).then(
            (value) {
          AwesomeDialog(
            context: context,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            title: MessagesApp.successUserInsert,
            btnOkOnPress: () => Navigator.pushNamedAndRemoveUntil(
                context, RoutesApp.homeHospedes, (Route<dynamic> route) => false),
            btnOkText: 'OK',
          ).show(); // Message
        },
      ).catchError((error) {
        if (error.toString().contains('UNIQUE constraint failed')) {
          MessagesApp.showCustom(
            context,
            MessagesApp.errorUserExist,
          );
        } else {
          MessagesApp.showCustom(
            context,
            MessagesApp.errorDefault,
          );
        }
      });
      // await db.saveUser(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Hospedes'),
      ),
      body: Form(
        key: _formKey,

        child: Center(
          child: Column(
            children: [
              UserTextField(
                hintName: 'CPF',
                icon: Icons.person,
                controller: _hospedeCPFController,
              ),
              UserTextField(
                hintName: 'Nome',
                icon: Icons.person,
                controller: _hospedeNomeController,
              ),
              Container (
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_month) ,
                    label: Text("Data de Nascimento"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                  readOnly: true,
                  controller: _hospedeDataNascimentoController,
                  onTap: () async {
                    DateTime? dataNasc = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2004),
                    firstDate: DateTime(1960),
                    lastDate: DateTime(2024));

                    int anoNasc = DateTime.parse(dataNasc.toString()).year.toInt();
                    int anoAtual = DateTime.now().year;

                    if (dataNasc != null && (anoAtual - anoNasc) >= 18) {

                      String dataFormatada = DateFormat('yyyy-MM-dd').format(dataNasc);
                      setState(() {
                        _hospedeDataNascimentoController.text = dataFormatada;
                      });
                    } else {

                    }
                  },
                ),
              ),

              UserTextField(
                hintName: 'Localidade',
                icon: Icons.person,
                controller: _hospedeLocalidadeController,
              ),
              UserTextField(
                hintName: 'Endereco',
                icon: Icons.person,
                controller: _userEnderecoController,
              ),

              ElevatedButton(
                onPressed: () => cadastrarHospede(context),
                style:
                ElevatedButton.styleFrom(shape: const StadiumBorder()),
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

        ),

      ),
    );
  }
}
