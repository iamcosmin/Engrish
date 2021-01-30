import 'Method/Database/Database.dart';
import 'Method/Login.dart';
import 'Method/Misc.dart';
import 'Method/Navigation.dart';
import 'Method/Update.dart';

// ignore: avoid_classes_with_only_static_members
/// Entry point to the Relays SDK.
/// This will be provided as is, without extra support
/// This is an internal file, it should not be provided externally without consent

class Core {
  static Login login = Login();
  static Misc misc = Misc();
  static Navigation navigate = Navigation();
  static Database db = Database();
  static Update update = Update();
}
