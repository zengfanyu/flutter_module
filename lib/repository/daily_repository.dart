import 'package:flutter_module/model/daily_model.dart';

abstract class DailyRepository {
  Future<DailyModel> loadData();
}