import 'package:t_or_d/constants/app_colors.dart';
import 'package:t_or_d/data/local/localstorage.dart';
import 'package:t_or_d/features/chat_screen/chat_screen_view.dart';
import 'package:t_or_d/features/play_physical/add_player/add_players_view.dart';
import 'package:t_or_d/features/play_physical/wheel_view/wheel_view.dart';
import 'package:t_or_d/features/t_or_d/bottom_nav_view.dart';
import 'package:t_or_d/onboarding/splash/splash_screen.dart';
import 'package:t_or_d/routes/exports.dart';
import 'package:device_preview/device_preview.dart';
import 'package:t_or_d/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*if (!kIsWeb) {
    await Firebase.initializeApp();
  }*/
  await LocalStorage.instance.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    //
    /*DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),*/

    const MyApp(),
  );

  //
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //
      //useInheritedMediaQuery: true,
      //locale: DevicePreview.locale(context),
      //builder: DevicePreview.appBuilder,
      //
      //theme: AppTheme.light(),
      //darkTheme: AppTheme.dark(),
      //themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF10225e, AppColors.primarySwatch),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
      ),
      home: const BottomNavigationView(),
      //getPages: RoutesClass.routes,
    );
  }
}
