import 'package:t_or_d/components/app_button.dart';
import 'package:t_or_d/components/app_textfield.dart';
import 'package:t_or_d/features/play_physical/add_player/add_players_controller.dart';
import 'package:t_or_d/routes/exports.dart';

class AddPlayersView extends StatelessWidget {
  const AddPlayersView({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = (brightness == Brightness.dark);
    return GetBuilder<AddPlayersController>(
      init: AddPlayersController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const AppText('Add Players'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: textAndTextField(
                      controller: controller.playerNameController,
                      formName: 'Add Player',
                      maxLine: 1,
                      minline: 1,
                      hintText: 'Enter Player name',
                    ),
                  ),
                  AppButton(
                    onPressed: () {
                      controller.addPlayer();
                    },
                    color: isDarkMode
                        ? Theme.of(context).cardColor
                        : AppColors.primaryColor,
                    radius: 15.0,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              controller.players.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20.0), //<-- SEE HERE
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: AppText(
                                        controller.players[index],
                                        size: 25,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.removePlayer(index);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8.0,
                          );
                        },
                        itemCount: controller.players.length,
                      ),
                    )
                  : const Expanded(
                      child: Center(
                        child: AppText(
                          'Please Add a Player',
                          size: 20,
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: AppButton(
                  onPressed: () {
                    controller.onContinue();
                  },
                  color: isDarkMode
                      ? Theme.of(context).cardColor
                      : AppColors.primaryColor,
                  radius: 20,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppText(
                          'Continue',
                          color: Colors.white,
                          size: 22,
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
              const SizedBox(
                height: 16.0,
              )
            ],
          ),
        );
      },
    );
  }
}

Widget textAndTextField({
  required TextEditingController controller,
  required String formName,
  String? hintText,
  int? maxLine,
  int? minline,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppTextField(
          textEditingController: controller,
          hintText: hintText,
          maxLines: maxLine,
          minLines: minline,
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          borderWidth: 2,
        )
      ],
    ),
  );
}
