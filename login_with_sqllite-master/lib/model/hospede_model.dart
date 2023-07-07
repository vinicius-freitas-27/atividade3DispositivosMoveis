class HospedeModel {
  String hospedeCPF;
  String hospedeNome;
  String hospedeDataNascimento;
  String hospedeLocalidade;
  String hospedeEndereco;

  HospedeModel({
    required this.hospedeCPF,
    required this.hospedeNome,
    required this.hospedeDataNascimento,
    required this.hospedeLocalidade,
    required this.hospedeEndereco,
  });

  int getIdade(){
    int anoNasc = DateTime.parse(hospedeDataNascimento).year;
    int anoAtual = DateTime.now().year;
    return anoAtual - anoNasc;
  }

  @override
  String toString() {
    return 'HospedeModel(hospedeCPF: $hospedeCPF, hospedeNome: $hospedeNome, hospedeDataNascimento: $hospedeDataNascimento, hospedeLocalidade: $hospedeLocalidade, hospedeEndereco: $hospedeEndereco)';
  }
}
