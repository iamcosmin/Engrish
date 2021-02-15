import 'package:engrish/Core/Core.dart';
import 'package:engrish/Core/Method/Database/Get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

import 'Ensure.dart';

class Database extends Core {
  Ensure ensure = Ensure();
  Get get = Get();

  //* Exception methods

  //* Refresh action
  /// Retreives the new name from the server and updates the cache.
  Future<String> refreshName() async {
    var pfs = await SharedPreferences.getInstance();
    var newName = await get.name();
    await pfs.setString('name', newName);
    return newName;
  }

  /// Retreives the new grade list from the server and updates the cache.
  Future<List<String>> refreshGrades() async {
    var pfs = await SharedPreferences.getInstance();
    List newGrades = await get.grades();
    var newStrGrades = newGrades.map((_) => _.toString()).toList();
    await pfs.setStringList('grades', newStrGrades);
    return newGrades as Future<List<String>>;
  }
}
