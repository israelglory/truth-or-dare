import 'package:t_or_d/features/generate_t_or_d/generate_t_or_d_view.dart';
import 'package:t_or_d/features/play_online/play_online_view.dart';
import 'package:t_or_d/features/play_physical/play_physical_view.dart';
import 'package:t_or_d/routes/exports.dart';

class BottomNavController extends GetxController {
  int selectedIndex = 0;
  final List children = [
    const PlayPhysicalView(),
    const GenerateTorDView(),
    const PlayOnlineView(),
  ];
  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}
