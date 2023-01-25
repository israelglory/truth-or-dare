import 'package:t_or_d/features/generate_t_or_d/generate_t_or_d_view.dart';
import 'package:t_or_d/features/play_physical/play_physical_view.dart';
import 'package:t_or_d/routes/exports.dart';

class BottomNavController extends GetxController {
  int selectedIndex = 1;
  final List children = [
    PlayPhysicalView(),
    GenerateTorDView(),
    Center(
      child: AppText('Play online'),
    ),
  ];
  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}
