import 'dart:convert';

List<TimepickedforTimerModel> timepickedforTimerModelFromJson(String str) =>
    List<TimepickedforTimerModel>.from(
        json.decode(str).map((x) => TimepickedforTimerModel.fromJson(x)));

String timepickedforTimerModelToJson(List<TimepickedforTimerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimepickedforTimerModel {
  TimepickedforTimerModel({
    this.autoId,
    this.time1,
  });

  int? autoId;
  String? time1;

  factory TimepickedforTimerModel.fromJson(Map<String, dynamic> json) =>
      TimepickedforTimerModel(
        autoId: json["auto_id"] == null ? null : json["auto_id"],
        time1: json["timee1"] == null ? null : json["timee1"],
      );

  Map<String, dynamic> toJson() => {
        "auto_id": autoId == null ? null : autoId,
        "timee1": time1 == null ? null : time1,
      };
}
