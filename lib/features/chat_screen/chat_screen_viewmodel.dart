import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_or_d/constants/firebase_constants.dart';
import 'package:t_or_d/data/local/localstorage.dart';
import 'package:t_or_d/data/repository/repo_implementation/t_or_d_repo_impl.dart';
import 'package:t_or_d/models/room_user_model.dart';
import 'package:t_or_d/models/t_or_d_models/room_model.dart';
import 'package:t_or_d/routes/exports.dart';
import 'package:t_or_d/services/messaging_service/message_service.dart';

class ChatScreenViewModel extends GetxController {
  final MessagingService chatService = MessagingService();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  String currentUserId = '';
  TruthOrDareRepoImpl tordRepo = TruthOrDareRepoImpl();
  bool inProgress = false;
  RoomModel rooomData = RoomModel();

  List<QueryDocumentSnapshot> listMessage = [];
  int limit = 20;
  int limitIncrement = 20;
  String groupChatId = "";

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";

  @override
  void initState() async {
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    await currentRoomData();
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

  Future<void> getAndSendQuestion(String type) async {
    if (type == 'truth') {
      try {
        inProgress = true;
        update();
        final truth = await tordRepo.truth();

        await FirebaseFirestore.instance
            .collection(FirestoreConstants.pathMessageCollection)
            .doc(currentUser.currentRoomId)
            .update(
          {
            'latest_question': '${currentUser.yourName}: ${truth.question}',
          },
        );
        inProgress = false;
        update();
      } on Exception catch (e) {
        inProgress = false;
        update();
        Get.snackbar(
          "Error",
          'Something Went Wrong',
          colorText: Colors.white,
          dismissDirection: DismissDirection.horizontal,
          backgroundColor: AppColors.appRed,
          snackPosition: SnackPosition.TOP,
        );
        log(e.toString());
      }
    } else if (type == 'wyr') {
      try {
        inProgress = true;
        update();
        final wyr = await tordRepo.wouldYouRather();
        await FirebaseFirestore.instance
            .collection(FirestoreConstants.pathMessageCollection)
            .doc(currentUser.currentRoomId)
            .update(
          {
            'latest_question': '${currentUser.yourName}: ${wyr.question}',
          },
        );
        inProgress = false;
        update();
      } on Exception catch (e) {
        inProgress = false;
        update();
        Get.snackbar(
          "Error",
          'Something Went Wrong',
          colorText: Colors.white,
          dismissDirection: DismissDirection.horizontal,
          backgroundColor: AppColors.appRed,
          snackPosition: SnackPosition.TOP,
        );
        log(e.toString());
      }
    } else {
      try {
        inProgress = true;
        update();
        final nhie = await tordRepo.neverHaveIEver();
        await FirebaseFirestore.instance
            .collection(FirestoreConstants.pathMessageCollection)
            .doc(currentUser.currentRoomId)
            .update(
          {
            'latest_question': '${currentUser.yourName}: ${nhie.question}',
          },
        );
        inProgress = false;
        update();
      } on Exception catch (e) {
        inProgress = false;
        update();
        Get.snackbar(
          "Error",
          'Something Went Wrong',
          colorText: Colors.white,
          dismissDirection: DismissDirection.horizontal,
          backgroundColor: AppColors.appRed,
          snackPosition: SnackPosition.TOP,
        );
        log(e.toString());
      }
    }
  }

  Future<void> currentRoomData() async {
    final userinfo = await getUserData();

    rooomData = RoomModel(
      roomName: userinfo['room_name'],
      creator: userinfo['group_creator'],
      groupId: userinfo['group_Id'],
      latestQuestion: userinfo['latest_question'],
    );
  }

  /// We can get user data through this function
  Future getUserData() async {
    final docRef = FirebaseFirestore.instance
        .collection('messages')
        .doc(currentUser.currentRoomId);

    final userData = docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data();
        return data;
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return userData;
  }

  RoomUserModel get currentUser => LocalStorage().getRoomUserState();
}
