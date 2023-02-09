import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:t_or_d/models/room_user_model.dart';

class LocalStorage {
  Box get appBox => Hive.box('truthordare');

  static LocalStorage instance = LocalStorage();

  LocalStorage();

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(RoomUserModelAdapter());
    await Hive.openBox("truthordare");
    log('boxOpend');
  }

  void setRoomUserState(RoomUserModel val) {
    appBox.put('currentRoom', val);
  }

  /*void setUserData(User val) {
    appBox.put('userData', val);
  }*/

  RoomUserModel getRoomUserState() {
    return appBox.get('currentRoom',
        defaultValue: RoomUserModel(
          currentRoomId: '',
          yourName: '',
          uId: '',
        ));
  }

  /*User getUserProfile() {
    return appBox.get(
      'userData',
      //defaultValue: null,
    );
  }*/

  void setAccessToken(String val) {
    appBox.put('accessToken', val);
  }

  String getAccessToken() {
    return appBox.get('accessToken', defaultValue: '');
  }

  void clearUserInfo() {
    appBox.delete('currentRoom');
  }

  void setBgMessageInit(bool val) {
    appBox.put('bgMessage', val);
  }

  bool getBgMessageInit() {
    return appBox.get('bgMessage', defaultValue: false);
  }
}


//visenyatargaryen@mailinator.com