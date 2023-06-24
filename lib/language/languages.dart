
import 'package:alphacue_vet_doc/language/ban.dart';
import 'package:alphacue_vet_doc/language/eng.dart';
import 'package:get/get.dart';
class Languages extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': eng,
    'bn_BD':ban,

  };


}