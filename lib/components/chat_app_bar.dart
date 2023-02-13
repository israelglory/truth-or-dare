import 'package:flutter/cupertino.dart';
import 'package:t_or_d/components/avatar.dart';
import 'package:t_or_d/routes/exports.dart';
import 'package:t_or_d/services/messaging_service/message_service.dart';

class ChatAppBar extends StatelessWidget with PreferredSizeWidget {
  const ChatAppBar({
    Key? key,
    required this.chatId,
    required this.roomName,
  }) : super(key: key);

  // final MessageData messageData;

  final String chatId;

  final String roomName;

  @override
  Widget build(BuildContext context) {
    //var brightness = MediaQuery.of(context).platformBrightness;
    //bool isDarkMode = (brightness == Brightness.dark);
    return SafeArea(
      top: true,
      bottom: false,
      left: false,
      right: false,
      //minimum: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26, //New
              blurRadius: 5.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        height: 56,
        width: double.infinity,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(CupertinoIcons.back),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const Avatar.medium(
              url: '',
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                  stream: MessagingService().getlatestQuestionStream(chatId),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          snapshot) {
                    return AppText(
                      snapshot.data!['room_name'],
                      size: 18,
                      maxLines: 1,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: chatId));
                Get.snackbar(
                  "Success",
                  '$chatId Have been copied',
                  colorText: Colors.white,
                  dismissDirection: DismissDirection.horizontal,
                  backgroundColor: AppColors.primaryColor,
                  snackPosition: SnackPosition.TOP,
                );
              },
              icon: const Icon(
                Icons.copy,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
