abstract class UserTableSchema {
  static const String nameTable = "user";
  static const String userIDColumn = 'id';
  static const String userNameColumn = 'name';
  static const String userEmailColumn = 'email';
  static const String userPasswordColumn = 'password';

  static String createUserTableScript() => '''
    CREATE TABLE $nameTable (
        $userIDColumn TEXT NOT NULL PRIMARY KEY, 
        $userNameColumn TEXT NOT NULL, 
        $userEmailColumn TEXT NOT NULL,
        $userPasswordColumn TEXT NOT NULL
        )
      ''';
}
