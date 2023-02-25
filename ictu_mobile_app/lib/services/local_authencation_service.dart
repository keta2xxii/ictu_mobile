import 'package:local_auth/local_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:local_auth_android/local_auth_android.dart';
// ignore: depend_on_referenced_packages
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuthService {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> canUseFaceId() async {
    if (await _localAuthentication.canCheckBiometrics) {
      var authentication = await _localAuthentication.getAvailableBiometrics();
      return authentication.isNotEmpty;
    }
    return false;
  }

  Future<bool> setUpFaceIdLogin() async {
    if (await canUseFaceId()) {
      const iosStrings = IOSAuthMessages(
        cancelButton: 'cancel',
        goToSettingsButton: 'settings',
        goToSettingsDescription: 'Please set up your Face ID.',
      );
      const androidString = AndroidAuthMessages(
        cancelButton: 'cancel',
        goToSettingsButton: 'settings',
        goToSettingsDescription: 'Please set up your Face ID.',
        biometricSuccess: 'Successful',
      );
      return _localAuthentication.authenticate(
        localizedReason: 'Please authenticate to login',
        authMessages: [
          iosStrings,
          androidString,
        ],
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } else {
      return false;
    }
  }
}
