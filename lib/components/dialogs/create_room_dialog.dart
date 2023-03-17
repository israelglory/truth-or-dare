import 'package:t_or_d/components/app_button.dart';
import 'package:t_or_d/components/app_textfield.dart';

import '../../routes/exports.dart';

class CreateRoomDialog extends StatelessWidget {
  final Function() onPressed;
  final TextEditingController nameController;
  final TextEditingController roomNameController;
  const CreateRoomDialog({
    Key? key,
    required this.onPressed,
    required this.nameController,
    required this.roomNameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          AppText(
            'Create Room',
            color: AppColors.primaryColor,
            size: 20,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 20,
          ),
          textAndTextField(
            controller: nameController,
            formName: 'Your Name',
            hintText: 'Splash',
          ),
          const SizedBox(
            height: 16,
          ),
          textAndTextField(
            controller: roomNameController,
            formName: 'Room Name',
            hintText: 'Cruise land',
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
                padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
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
                //padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                width: 120,
                onPressed: onPressed,
                child: const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: AppText(
                    'Create Room',
                    color: Colors.white,
                    size: 14,
                    fontWeight: FontWeight.w400,
                  ),
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

Widget textAndTextField({
  required TextEditingController controller,
  required String formName,
  String? hintText,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      AppText(
        formName,
        size: 14,
      ),
      const SizedBox(
        height: 4,
      ),
      AppTextField(
        textEditingController: controller,
        hintText: hintText,
        maxLines: 1,
        textInputType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        borderWidth: 2,
      )
    ],
  );
}
