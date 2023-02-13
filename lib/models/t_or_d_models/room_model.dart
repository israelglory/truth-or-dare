import 'package:t_or_d/routes/exports.dart';

class RoomModel {
  final String? groupId;

  final String? latestQuestion;
  final String? roomName;

  final String? creator;

  RoomModel({
    this.groupId,
    this.latestQuestion,
    this.roomName,
    this.creator,
  });

  factory RoomModel.fromFirestore(DocumentSnapshot map) {
    return RoomModel(
      roomName: map['room_name'],
      creator: map['group_creator'],
      groupId: map['group_Id'],
      latestQuestion: map['latest_question'],
    );
  }
}
