import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _alreadyLogin = 'alreadyLogin';

  IOSOptions _getIOSOptions() => const IOSOptions();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> deleteAll() async {
    await _storage.deleteAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  static Future setAlreadyLogin(String alreadyLogin) async {
    await _storage.write(key: _alreadyLogin, value: alreadyLogin);
  }

  static Future<String?> getAlreadyLogin() async {
    return await _storage.read(key: _alreadyLogin);
  }
}
