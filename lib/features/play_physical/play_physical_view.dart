import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:t_or_d/components/app_button.dart';
import 'package:t_or_d/features/play_physical/add_player/add_players_view.dart';
import 'package:t_or_d/features/play_physical/play_physical_controller.dart';
import 'package:t_or_d/routes/exports.dart';

class PlayPhysicalView extends StatelessWidget {
  const PlayPhysicalView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayPhysicalController>(
      init: PlayPhysicalController(),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Center(
            child: AppButton(
              onPressed: () {
                Get.to(() => AddPlayersView());
              },
              color: AppColors.primaryColor,
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    AppText(
                      'Play Now',
                      size: 22,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(Icons.arrow_forward_ios_outlined)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
