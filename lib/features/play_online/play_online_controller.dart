import 'dart:developer';

import 'package:t_or_d/components/dialogs/join_room_dialog.dart';
import 'package:t_or_d/components/dialogs/create_room_dialog.dart';
import 'package:t_or_d/constants/firebase_constants.dart';
import 'package:t_or_d/data/local/localstorage.dart';
import 'package:t_or_d/features/chat_screen/chat_screen_view.dart';
import 'package:t_or_d/models/room_user_model.dart';
import 'package:t_or_d/routes/exports.dart';
import 'dart:math' as math;

class PlayOnlineController extends GetxController {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController roomIdTextEditingController = TextEditingController();
  TextEditingController roomNameTextEditingController = TextEditingController();

  Future<void> onCreateRoom() async {
    Get.defaultDialog(
      title: '',
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      content: CreateRoomDialog(
        onPressed: () async {
          if (nameTextEditingController.text.isEmpty) {
            Get.snackbar(
              "Error",
              'Name cannot be empty',
              colorText: Colors.white,
              dismissDirection: DismissDirection.horizontal,
              backgroundColor: AppColors.appRed,
              snackPosition: SnackPosition.TOP,
            );
          } else if (roomNameTextEditingController.text.isEmpty) {
            Get.snackbar(
              "Error",
              'Room Name cannot be empty',
              colorText: Colors.white,
              dismissDirection: DismissDirection.horizontal,
              backgroundColor: AppColors.appRed,
              snackPosition: SnackPosition.TOP,
            );
          } else {
            final roomId = getRandomNumber();
            try {
              final userCredential =
                  await FirebaseAuth.instance.signInAnonymously();

              await createRoom(roomId.toString(), userCredential.user!.uid);
              LocalStorage().setRoomUserState(
                RoomUserModel(
                    currentRoomId: roomId.toString(),
                    yourName: nameTextEditingController.text,
                    uId: userCredential.user!.uid),
              );
              Get.to(() => const ChatScreen());
            } on Exception catch (e) {
              log(e.toString());
              Get.snackbar(
                "Error",
                'Unable to create Room',
                colorText: Colors.white,
                dismissDirection: DismissDirection.horizontal,
                backgroundColor: AppColors.appRed,
                snackPosition: SnackPosition.TOP,
              );
            }
          }
        },
        nameController: nameTextEditingController,
        roomNameController: roomNameTextEditingController,
      ),
    );
  }

  int getRandomNumber() {
    var rnd = math.Random();
    var next = rnd.nextDouble() * 10000000000;
    while (next < 1000000000) {
      next *= 10;
    }
    return next.toInt();
  }

  Future<void> onJoinRoom() async {
    Get.defaultDialog(
      title: '',
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      content: JoinRoomDialog(
        onPressed: () async {
          if (nameTextEditingController.text.isEmpty) {
            Get.snackbar(
              "Error",
              'Name cannot be empty',
              colorText: Colors.white,
              dismissDirection: DismissDirection.horizontal,
              backgroundColor: AppColors.appRed,
              snackPosition: SnackPosition.TOP,
            );
          } else if (roomIdTextEditingController.text.isEmpty) {
            Get.snackbar(
              "Error",
              'Room Id cannot be empty',
              colorText: Colors.white,
              dismissDirection: DismissDirection.horizontal,
              backgroundColor: AppColors.appRed,
              snackPosition: SnackPosition.TOP,
            );
          } else {
            final userCredential =
                await FirebaseAuth.instance.signInAnonymously();
            print(userCredential.user!.uid);
            final docRef = FirebaseFirestore.instance
                .collection('messages')
                .doc(roomIdTextEditingController.text);

            DocumentSnapshot snap = await docRef.get();
            if (snap.exists) {
              LocalStorage().setRoomUserState(
                RoomUserModel(
                  currentRoomId: roomIdTextEditingController.text,
                  yourName: nameTextEditingController.text,
                  uId: userCredential.user!.uid,
                ),
              );
              Get.to(() => const ChatScreen());
              update();
            } else {
              Get.snackbar(
                "Error",
                'Invalid Room number',
                colorText: Colors.white,
                dismissDirection: DismissDirection.horizontal,
                backgroundColor: AppColors.appRed,
                snackPosition: SnackPosition.TOP,
              );
              update();
            }
          }
        },
        roomIdController: roomIdTextEditingController,
        nameController: nameTextEditingController,
      ),
    );
  }

  Future<void> createRoom(String roomId, String uid) async {
    await FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(roomId)
        .set(
      {
        'group_creator': nameTextEditingController.text,
        'group_Id': uid,
        'room_name': roomNameTextEditingController.text,
      },
    );
  }

  Future<void> resolveRoom(String roomId) async {}
}
