import 'dart:developer';

import 'package:t_or_d/components/dialogs/show_picked_option.dart';
import 'package:t_or_d/data/repository/repo_implementation/t_or_d_repo_impl.dart';
import 'package:t_or_d/routes/exports.dart';

class GenerateTorDController extends GetxController {
  TruthOrDareRepoImpl tordRepo = TruthOrDareRepoImpl();
  bool inProgress = false;

  Future<void> getTruth() async {
    try {
      inProgress = true;
      update();
      final truth = await tordRepo.truth();
      inProgress = false;
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
      log(e.toString());
      inProgress = false;
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
      inProgress = true;
      update();
      final dare = await tordRepo.dare();
      inProgress = false;
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
      inProgress = false;
      update();
      Get.snackbar(
        "Error",
        'Something Went Wrong',
        colorText: Colors.white,
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
      log(e.toString());
    }
  }

  Future<void> getwyr() async {
    try {
      inProgress = true;
      update();
      final wyr = await tordRepo.wouldYouRather();
      inProgress = false;
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
      inProgress = false;
      update();
      Get.snackbar(
        "Error",
        'Something Went Wrong',
        colorText: Colors.white,
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
      log(e.toString());
    }
  }

  Future<void> getNhie() async {
    try {
      inProgress = true;
      update();
      final nhie = await tordRepo.neverHaveIEver();
      inProgress = false;
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
      inProgress = false;
      update();
      Get.snackbar(
        "Error",
        'Something Went Wrong',
        colorText: Colors.white,
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppColors.appRed,
        snackPosition: SnackPosition.TOP,
      );
      log(e.toString());
    }
  }
}
