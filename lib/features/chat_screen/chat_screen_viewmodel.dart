import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_or_d/constants/firebase_constants.dart';
import 'package:t_or_d/data/local/localstorage.dart';
import 'package:t_or_d/models/room_user_model.dart';
import 'package:t_or_d/routes/exports.dart';
import 'package:t_or_d/services/messaging_service/message_service.dart';

class ChatScreenViewModel extends GetxController {
  final MessagingService chatService = MessagingService();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  String currentUserId = '';

  List<QueryDocumentSnapshot> listMessage = [];
  int limit = 20;
  int limitIncrement = 20;
  String groupChatId = "";

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";

  void initState(String initpeerId) {
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    //readLocal();
    update();
  }

  _scrollListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        limit <= listMessage.length) {
      limit += limitIncrement;
      update();
    }
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear

      isShowSticker = false;
      update();
    }
  }

  /*void readLocal() {
    if (currentUserId.compareTo(peerId) > 0) {
      groupChatId = '$currentUserId-$peerId';
    } else {
      groupChatId = '$peerId-$currentUserId';
    }

    chatService.updateDataFirestore(
      FirestoreConstants.pathUserCollection,
      currentUserId,
      {FirestoreConstants.chattingWith: peerId},
    );
  }*/

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;

    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        isLoading = true;
        update();
        uploadFile();
      }
    }
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();

    isShowSticker = !isShowSticker;
    update();
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = chatService.uploadFile(imageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();

      isLoading = false;
      onSendMessage(imageUrl, TypeMessage.image);
      update();
    } on FirebaseException catch (e) {
      isLoading = false;
      update();
      Get.snackbar(
        "Error",
        e.message!,
        colorText: Colors.white,
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatService.sendMessage(
        content,
        type,
        currentUser.currentRoomId,
        currentUser.uId,
      );
      if (listScrollController.hasClients) {
        listScrollController.animateTo(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      Get.snackbar(
        "Error",
        'Nothing to send',
        colorText: Colors.white,
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  RoomUserModel get currentUser => LocalStorage().getRoomUserState();
}
