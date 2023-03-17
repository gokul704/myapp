import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<Map<String, String>> getAllValues() {
    return this._secureStorage.readAll();
  }

  Future<String?> getValue(String key) async {
    return this._secureStorage.read(key: key);
  }

  Future<void> setValue(String key, String value) async {
    return this._secureStorage.write(key: key, value: value);
  }

  Future<void> removeValue(String key) async {
    return this._secureStorage.delete(key: key);
  }

  Future<void> clearStore() async {
    return this._secureStorage.deleteAll();
  }
}
