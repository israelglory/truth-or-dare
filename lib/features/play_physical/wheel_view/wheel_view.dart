import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:t_or_d/features/play_physical/wheel_view/wheel_viewmodel.dart';
import 'package:t_or_d/routes/exports.dart';

class WheelView extends StatelessWidget {
  const WheelView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: WheelViewModel(),
      builder: (controller) {
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              controller.ontap();
            },
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: FortuneWheel(
                      //rotationCount: 4,
                      //selected: Stream.value(0),
                      indicators: <FortuneIndicator>[
                        const FortuneIndicator(
                          alignment: Alignment
                              .bottomCenter, // <-- changing the position of the indicator
                          child: TriangleIndicator(
                            color: Colors
                                .green, // <-- changing the color of the indicator
                          ),
                        ),
                      ],
                      physics: CircularPanPhysics(
                        duration: const Duration(seconds: 1),
                        curve: Curves.decelerate,
                      ),
                      onFling: () {
                        //controller.controller.add(1);
                      },
                      onAnimationEnd: () {},
                      selected: controller.controller.stream,
                      items: controller.players
                          .map(
                            (e) => FortuneItem(
                              child: AppText(
                                e,
                                size: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    //height: 10,
                    child: AppText(
                      Fortune.randomItem(controller.players),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
