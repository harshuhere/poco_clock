// To parse this JSON data, do
//
//     final alarmModel = alarmModelFromJson(jsonString);

import 'dart:convert';

List<AlarmModel> alarmModelFromJson(dynamic str) =>
    List<AlarmModel>.from(str.map((x) => AlarmModel.fromJson(x)));

String alarmModelToJson(List<AlarmModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlarmModel {
  AlarmModel({
    this.autoId,
    this.time1,
    this.ringtone,
    this.repeat,
    this.vibrate,
    this.delete1,
    this.isEnable,
    this.label,
  });

  int? autoId;
  String? time1;
  String? ringtone;
  String? repeat;
  String? vibrate;
  String? delete1;
  String? isEnable;
  String? label;

  factory AlarmModel.fromJson(Map<String, dynamic> json) => AlarmModel(
        autoId: json["auto_id"] == null ? 0 : json["auto_id"],
        time1: json["time1"] == null ? "" : json["time1"],
        ringtone: json["ringtone"] == null ? "" : json["ringtone"],
        repeat: json["repeat"] == null ? "" : json["repeat"],
        vibrate: json["vibrate"] == null ? "" : json["vibrate"],
        delete1: json["delete1"] == null ? "" : json["delete1"],
        isEnable: json["isEnable"] == null ? "" : json["isEnable"],
        label: json["label"] == null ? "" : json["label"],
      );

  Map<String, dynamic> toJson() => {
        "auto_id": autoId == null ? 0 : autoId,
        "time1": time1 == null ? "" : time1,
        "ringtone": ringtone == null ? "" : ringtone,
        "repeat": repeat == null ? "" : repeat,
        "vibrate": vibrate == null ? "" : vibrate,
        "delete1": delete1 == null ? "" : delete1,
        "isEnable": isEnable == null ? "" : isEnable,
        "label": label == null ? "" : label,
      };
}
