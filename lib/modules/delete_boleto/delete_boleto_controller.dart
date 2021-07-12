import 'package:shared_preferences/shared_preferences.dart';

class DeleteBoletoController {
  delBoleto(
    String? name,
    String? dueData,
    double? value,
    String? barCode,
  ) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    final boletos = instance.getStringList("boletos");
    //boletos!.removeAt(0);
    boletos!.removeWhere((element) => element.contains(name.toString()));
    await instance.setStringList("boletos", boletos);
    return;
  }
}
