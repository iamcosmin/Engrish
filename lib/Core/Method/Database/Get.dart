import 'package:engrish/Core/Core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Get extends Core {
  //* Token operations

  /// Returns the token of the user, stored in SharedPreferences.
  Future<String> token() async {
    var pfs = await SharedPreferences.getInstance();
    var token = pfs.getString('token');
    return token;
  }

  /// Returns the list of all tokens, stored in SharedPreferences.
  Future<List<String>> tokenList() async {
    var pfs = await SharedPreferences.getInstance();
    var tokens = pfs.getStringList('tokens');
    return tokens;
  }

  //* Getting cached elements

  /// Returns name of user, cached in SharedPreferences
  Future<String> name() async {
    var pfs = await SharedPreferences.getInstance();
    var name = pfs.getString('name');
    return name;
  }

  /// Returns grades of the user, cached in SharedPreferences
  Future<List<int>> grades() async {
    var pfs = await SharedPreferences.getInstance();
    var strGrades = pfs.getStringList('grades');
    var grades = strGrades.map((i) => int.parse(i)).toList();
    return grades;
  }

  //* Functions with only internal use

  /// Gets the path of the user directory in Firestore
  Future<DocumentSnapshot> userDatabasePath() async {
    var firestore = FirebaseFirestore.instance;
    var tkn = await token();
    var path = await firestore.collection('user').doc(tkn).get();
    return path;
  }

  //* Fetching internet elements

  /// Gets the user name String
  Future<String> onlineName() async {
    var path = await userDatabasePath();
    var name = path['name'] as String;
    return name;
  }

  /// Gets a list of grades of the user
  Future<List> onlineGrades() async {
    var path = await userDatabasePath();
    var grades = path['grades'] as List;
    return grades;
  }
}
