import 'package:flutter/cupertino.dart';
import 'package:t_or_d/components/avatar.dart';
import 'package:t_or_d/routes/exports.dart';

class ChatAppBar extends StatelessWidget with PreferredSizeWidget {
  const ChatAppBar({
    Key? key,
    //required this.chatId,
    required this.roomName,
  }) : super(key: key);

  // final MessageData messageData;

  //final String chatId;

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
            Avatar.medium(
              url: '',
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    roomName,
                    size: 18,
                    maxLines: 1,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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
