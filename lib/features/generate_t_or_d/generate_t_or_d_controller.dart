import 'package:t_or_d/components/dialogs/show_picked_option.dart';
import 'package:t_or_d/data/repository/repo_implementation/t_or_d_repo_impl.dart';
import 'package:t_or_d/routes/exports.dart';

class GenerateTorDController extends GetxController {
  TruthOrDareRepoImpl tordRepo = TruthOrDareRepoImpl();
  bool truthInProgress = false;
  bool dareInProgress = false;
  bool wyrInProgress = false;
  bool nhieInProgress = false;

  Future<void> getTruth() async {
    try {
      truthInProgress = true;
      update();
      final truth = await tordRepo.truth();
      truthInProgress = false;
      update();
      Get.defaultDialog(
        title: '',
        titlePadding: const EdgeInsets.all(0.0),
        contentPadding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        content: ShowPickedDialog(
            onPressed: () async {},
            content: truth.question ?? 'Error Please genrate again'),
      );
    } on Exception catch (e) {
      truthInProgress = false;
      update();
      Get.snackbar(
        "Error",
        'Something Went Wrong',
        colorText: Colors.white,
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> getDare() async {
    try {
      dareInProgress = true;
      update();
      final dare = await tordRepo.dare();
      dareInProgress = false;
      update();
      Get.defaultDialog(
        title: '',
        titlePadding: const EdgeInsets.all(0.0),
        contentPadding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        content: ShowPickedDialog(
            onPressed: () async {},
            content: dare.question ?? 'Error Please genrate again'),
      );
    } on Exception catch (e) {
      dareInProgress = false;
      update();
      Get.snackbar(
        "Error",
        'Something Went Wrong',
        colorText: Colors.white,
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> getwyr() async {
    try {
      wyrInProgress = true;
      update();
      final wyr = await tordRepo.wouldYouRather();
      wyrInProgress = false;
      update();
      Get.defaultDialog(
        title: '',
        titlePadding: const EdgeInsets.all(0.0),
        contentPadding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        content: ShowPickedDialog(
            onPressed: () async {},
            content: wyr.question ?? 'Error Please genrate again'),
      );
    } on Exception catch (e) {
      wyrInProgress = false;
      update();
      Get.snackbar(
        "Error",
        'Something Went Wrong',
        colorText: Colors.white,
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> getNhie() async {
    try {
      nhieInProgress = true;
      update();
      final nhie = await tordRepo.neverHaveIEver();
      nhieInProgress = false;
      update();
      Get.defaultDialog(
        title: '',
        titlePadding: const EdgeInsets.all(0.0),
        contentPadding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        content: ShowPickedDialog(
            onPressed: () async {},
            content: nhie.question ?? 'Error Please genrate again'),
      );
    } on Exception catch (e) {
      nhieInProgress = false;
      update();
      Get.snackbar(
        "Error",
        'Something Went Wrong',
        colorText: Colors.white,
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
