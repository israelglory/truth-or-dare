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
          padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
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
                gridItem('TRUTH'),
                gridItem('DARE'),
                gridItem('Would You Rather'),
                gridItem('Never Have I Ever')
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget gridItem(String name) {
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
      child: AppText(
        name,
        color: Colors.black,
        size: 25,
      ),
    ),
  );
}
