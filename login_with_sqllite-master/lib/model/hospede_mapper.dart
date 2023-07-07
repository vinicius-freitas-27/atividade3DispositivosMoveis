import 'package:login_with_sqllite/external/database/hospede_table_schema.dart';
import 'package:login_with_sqllite/model/hospede_model.dart';

abstract class HospedeMapper {
  // Mapeia um Usuario para o formato a ser salvo
  // no banco de dados
  static Map<String, dynamic> toMapBD(HospedeModel hospede) {
    return {
      HospedeTableSchema.hospedeCPFColumn: hospede.hospedeCPF,
      HospedeTableSchema.hospedeDataNascimentoColumn: hospede.hospedeDataNascimento,
      HospedeTableSchema.hospedeLocalidadeColumn: hospede.hospedeLocalidade,
      HospedeTableSchema.hospedeEnderecoColumn: hospede.hospedeEndereco,
      HospedeTableSchema.hospedeNomeColumn: hospede.hospedeNome,
    };
  }

  // Mapeia um Map vindo do SqlLite para um
  // uma classer UserModel
  static HospedeModel fromMapBD(Map<String, dynamic> map) {
    return HospedeModel(
      hospedeCPF: map[HospedeTableSchema.hospedeCPFColumn],
      hospedeDataNascimento: map[HospedeTableSchema.hospedeDataNascimentoColumn],
      hospedeLocalidade: map[HospedeTableSchema.hospedeLocalidadeColumn],
      hospedeEndereco: map[HospedeTableSchema.hospedeEnderecoColumn],
      hospedeNome: map[HospedeTableSchema.hospedeNomeColumn],
    );
  }

  // clona um UserModel
  static HospedeModel cloneUser(HospedeModel hospede) {
    return HospedeModel(
      hospedeCPF: hospede.hospedeCPF,
      hospedeDataNascimento: hospede.hospedeDataNascimento,
      hospedeLocalidade: hospede.hospedeLocalidade,
      hospedeEndereco: hospede.hospedeEndereco,
      hospedeNome: hospede.hospedeNome,
    );
  }
}
