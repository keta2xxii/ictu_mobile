import 'package:ictu_mobile_app/models/user_model.dart';
import 'package:ictu_mobile_app/services/api_service.dart';

import '../models/result_model.dart';

class UserRepository {
  Future<BaseDecoder<UserModel>> getUserProfile() async {
    return BaseDecoder(
      await (await RestClient.create()).getUserProfile(),
      decoder: UserModel.fromJson,
    );
  }
}
