import 'package:loader_overlay/loader_overlay.dart';
import 'package:t_or_d/features/generate_t_or_d/generate_t_or_d_controller.dart';
import 'package:t_or_d/routes/exports.dart';

class GenerateTorDView extends StatelessWidget {
  const GenerateTorDView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GenerateTorDController>(
      init: GenerateTorDController(),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
          child: Center(
            child: GridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              //maxCrossAxisExtent: 300,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: [
                InkWell(
                  onTap: () async {
                    await controller.getTruth();
                  },
                  child: gridItem('TRUTH', controller.truthInProgress),
                ),
                InkWell(
                  onTap: () async {
                    await controller.getDare();
                  },
                  child: gridItem('DARE', controller.dareInProgress),
                ),
                InkWell(
                  onTap: () async {
                    await controller.getwyr();
                  },
                  child: gridItem('Would You Rather', controller.wyrInProgress),
                ),
                InkWell(
                  onTap: () async {
                    await controller.getNhie();
                  },
                  child:
                      gridItem('Never Have I Ever', controller.nhieInProgress),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget gridItem(String name, bool inProgress) {
  return Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2), //New
          blurRadius: 15,
          blurStyle: BlurStyle.normal,
          spreadRadius: 5,
          // offset: Offset(0, 0),
        ),
      ],
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.white,
    ),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            name,
            color: Colors.black,
            size: 25,
          ),
          Visibility(
            visible: inProgress,
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    ),
  );
}
