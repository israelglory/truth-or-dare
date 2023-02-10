import 'package:t_or_d/components/app_button.dart';
import 'package:t_or_d/components/app_textfield.dart';

import '../../routes/exports.dart';

class ShowPickedDialog extends StatelessWidget {
  final Function() onPressed;
  final String content;
  const ShowPickedDialog({
    Key? key,
    required this.onPressed,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          AppText(
            'Truth or Dare',
            color: AppColors.primaryColor,
            size: 20,
            alignment: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 20,
          ),
          AppText(
            content,
            size: 20,
            alignment: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppButton(
                radius: 8,
                color: AppColors.appRed,
                padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                width: 120,
                onPressed: () {
                  Get.back();
                },
                child: const AppText(
                  'Cancel',
                  color: Colors.white,
                  size: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              AppButton(
                radius: 8,
                color: AppColors.primaryColor,
                padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                width: 120,
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: content));
                  Get.snackbar(
                    "Success",
                    '$content Have been copied',
                    colorText: Colors.white,
                    dismissDirection: DismissDirection.horizontal,
                    backgroundColor: AppColors.primaryColor,
                    snackPosition: SnackPosition.TOP,
                  );
                },
                child: const AppText(
                  'Copy',
                  color: Colors.white,
                  size: 14,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
