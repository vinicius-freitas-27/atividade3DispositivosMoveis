abstract class HospedeTableSchema {
  static const String nameTable = "hospede";
  static const String hospedeCPFColumn = 'CPF';
  static const String hospedeDataNascimentoColumn = 'datanascimento';
  static const String hospedeLocalidadeColumn = 'localidade';
  static const String hospedeEnderecoColumn = 'endereco';
  static const String hospedeNomeColumn = 'nome';

  static String createHospedeTableScript() => '''
    CREATE TABLE $nameTable (
        $hospedeCPFColumn TEXT NOT NULL PRIMARY KEY, 
        $hospedeDataNascimentoColumn TEXT NOT NULL, 
        $hospedeLocalidadeColumn TEXT NOT NULL,
        $hospedeEnderecoColumn TEXT NOT NULL,
        $hospedeNomeColumn TEXT NOT NULL
        )
      ''';
}
