// To parse this JSON data, do
//
//     final selectedCityModel = selectedCityModelFromJson(jsonString);

import 'dart:convert';

List<SelectedCityModel> selectedCityModelFromJson(String str) =>
    List<SelectedCityModel>.from(
        json.decode(str).map((x) => SelectedCityModel.fromJson(x)));

String selectedCityModelToJson(List<SelectedCityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SelectedCityModel {
  SelectedCityModel({
    this.autoId,
    this.selectedCityName,
    this.timeDifference,
  });

  int? autoId;
  String? selectedCityName;
  String? timeDifference;

  factory SelectedCityModel.fromJson(Map<String, dynamic> json) =>
      SelectedCityModel(
        autoId: json["auto_id"] == null ? null : json["auto_id"],
        selectedCityName:
            json["selectedCityName"] == null ? null : json["selectedCityName"],
        timeDifference:
            json["timeDifference"] == null ? null : json["timeDifference"],
      );

  Map<String, dynamic> toJson() => {
        "auto_id": autoId == null ? null : autoId,
        "selectedCityName": selectedCityName == null ? null : selectedCityName,
        "timeDifference": timeDifference == null ? null : timeDifference,
      };
}
