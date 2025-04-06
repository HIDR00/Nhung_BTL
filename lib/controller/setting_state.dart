import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:iot_app/model/history_model.dart';
import 'package:iot_app/model/main_model.dart';

class settingState extends ChangeNotifier {
  Box mainBox = Hive.box('main');
  bool _type = true;
  List<MainModel> _lMainModel = [];
  String _alertTimeWater = "";
  String _alertTimeFood = "";
  String _volumeTimeWater = "100";
  String _volumeTimeFood = "100";
  List<HistoryModel> lHistory = [];

  bool get type => _type;
  List<MainModel> get lMainModel => _lMainModel;
  String get alertTimeWater => _alertTimeWater;
  String get alertTimeFood => _alertTimeFood;

  String get volumeTimeWater => _volumeTimeWater;
  String get volumeTimeFood => _volumeTimeFood;

  void changeType(bool newValue) {
    _type = newValue;
    getLMainModel();
    notifyListeners();
  }

  void fetchData(listDay) async {
    var foodModelList = mainBox.get('listFoodModel');
    var waterModelList = mainBox.get('listWaterModel');
    if ((foodModelList == null) && (waterModelList == null)) {
      List<MainModel> tmpModelFood = [];
      List<MainModel> tmpModelWater = [];
      for (var i in listDay) {
        MainModel foodModel = MainModel(dateTime: i, type: 0);
        MainModel waterModel = MainModel(dateTime: i, type: 1);
        tmpModelFood.add(foodModel);
        tmpModelWater.add(waterModel);
      }
      mainBox.put('listFoodModel', tmpModelFood);
      mainBox.put('listWaterModel', tmpModelWater);
    }
  }

  void getLMainModel() {
    List<dynamic> tmp = _type == true
        ? mainBox.get('listFoodModel')
        : mainBox.get('listWaterModel');
    _lMainModel = List<MainModel>.from(tmp.map((e) => e as MainModel));
  }

  void upDateLMainModel(index, value) {
    _lMainModel[index].progress += value;
    _lMainModel = List.from(_lMainModel);
    _type == true
        ? mainBox.put('listFoodModel', _lMainModel)
        : mainBox.put('listWaterModel', _lMainModel);
    insertHistory(value * 100);
    notifyListeners();
  }

  void updateTimeWater(String newValue) {
    _alertTimeWater = newValue;
    notifyListeners();
  }

  void updateTimeFood(String newValue) {
    _alertTimeFood = newValue;
    notifyListeners();
  }

  void updateVolumeWater(String newValue) {
    _volumeTimeWater = newValue;
    notifyListeners();
  }

  void updateVolumeFood(String newValue) {
    _volumeTimeFood = newValue;
    notifyListeners();
  }

  void insertHistory(value) {
    lHistory.insert(
        0, HistoryModel(dateTime: DateTime.now(), type: type, volume: value));
  }


}
