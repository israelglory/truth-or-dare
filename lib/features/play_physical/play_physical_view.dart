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
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                //color: Colors.,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Image.asset(
                  'assets/images/fun.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: AppText(
                  'Play with your friends physically. Have the upmost fun you can ever have together. Click on Play now',
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
                  onPressed: () {
                    Get.to(() => const AddPlayersView());
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
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
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
