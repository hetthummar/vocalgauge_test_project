
import 'package:singer_app/app/locator.dart';
import 'package:singer_app/utils/api_result/api_result.dart';
import 'package:singer_app/utils/client.dart';

class ApiService{

  Client _client = locator<Client>();

  ApiService() {
    _client =  Client();
  }
  
  Future<ApiResult> addMusicList(Map<String, dynamic> mp) async{

    try {
      await _client.builder().build().post("/music",data: mp);
      return const ApiResult.success(data: true);
    } catch (e) {
      return ApiResult.failure(error: e.toString());
    }

  }

  
}