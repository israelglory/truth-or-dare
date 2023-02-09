import 'package:hive/hive.dart';
part 'room_user_model.g.dart';

@HiveType(typeId: 1)
class RoomUserModel {
  @HiveField(0)
  String currentRoomId;
  @HiveField(1)
  String yourName;
  @HiveField(2)
  String uId;

  RoomUserModel(
      {required this.currentRoomId, required this.yourName, required this.uId});
}
