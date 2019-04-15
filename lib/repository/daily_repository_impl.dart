import 'package:flutter_module/api/daily_api.dart';
import 'package:flutter_module/model/daily_model.dart';
import 'package:flutter_module/repository/daily_repository.dart';
import 'package:dio/dio.dart';


class DailyRepositoryImpl implements DailyRepository {

  @override
  Future<DailyModel> loadData() async{
    Response response;
    Dio dio = new Dio();
    response = await dio.get(DailyApi.LATEST_DAILY);
    print("loadData $response");
    if(response.statusCode == 200) {
      return new DailyModel.fromJson(response.data);
    } else{
      return null;
    }
  }

}