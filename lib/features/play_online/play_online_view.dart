import 'package:t_or_d/components/app_button.dart';
import 'package:t_or_d/features/play_online/play_online_controller.dart';
import 'package:t_or_d/features/play_physical/add_player/add_players_view.dart';
import 'package:t_or_d/routes/exports.dart';

class PlayOnlineView extends StatelessWidget {
  const PlayOnlineView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayOnlineController>(
      init: PlayOnlineController(),
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                //color: Colors.,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Image.asset(
                  'assets/images/fun.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: AppText(
                  'Play with your friends online. Have the upmost fun you can ever have together.',
                  alignment: TextAlign.center,
                  size: 16,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: AppButton(
                  radius: 50,
                  onPressed: () async {
                    await controller.onJoinRoom();
                    //Get.to(() => const AddPlayersView());
                  },
                  color: AppColors.primaryColor,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppText(
                          'Join Room',
                          size: 22,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.group,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: AppButton(
                  radius: 50,
                  onPressed: () async {
                    await controller.onCreateRoom();
                    // Get.to(() => const AddPlayersView());
                  },
                  color: AppColors.appRed,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppText(
                          'Create room',
                          size: 22,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.group_add_rounded,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
