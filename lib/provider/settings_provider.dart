import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:touch_sender/provider/shared_preferences_provider.dart';

part 'settings_provider.g.dart';

@riverpod
class IpAddress extends _$IpAddress {
  static const initialValue = '192.168.1.15';
  @override
  String build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    listenSelf((prev, next) {
      preferences.setString(SharedPreferencesKeys.ipAddress, next);
    });
    final ipAddress = preferences.getString(SharedPreferencesKeys.ipAddress);
    if (ipAddress?.split('.').length != 4) {
      return initialValue;
    }
    return ipAddress!;
  }

  void setIpAddress(String value) {
    state = value;
  }

  void setIpAddressByIndex(int index, int value) {
    if (index < 0 || index > 3) {
      throw ArgumentError('index must be between 0 and 3');
    }
    if (value < 0) {
      throw ArgumentError('value must be greater than or equal to 0');
    }
    final ipAddress = state.split('.');
    ipAddress[index] = value.toString();
    state = ipAddress.join('.');
  }
}

@riverpod
class IsDarkTheme extends _$IsDarkTheme {
  @override
  bool build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    listenSelf((prev, next) {
      preferences.setBool(SharedPreferencesKeys.isDarkTheme, next);
    });
    return preferences.getBool(SharedPreferencesKeys.isDarkTheme) ?? true;
  }

  void setIsDarkTheme(bool value) {
    state = value;
  }
}
