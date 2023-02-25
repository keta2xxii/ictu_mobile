import 'package:ictu_mobile_app/services/api_service.dart';

import '../models/result_model.dart';

class AuthenticationRepository {
  Future<Result> login({
    required String username,
    required String password,
  }) async {
    return await (await RestClient.create()).login(
      username,
      password,
    );
  }
}
