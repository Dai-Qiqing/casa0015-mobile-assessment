import 'package:get/get.dart';

import 'index.dart';

class AppPages {
  static const INITIAL = AppRoutes.AUTH;

  static final routes = [
    GetPage(
      name: AppRoutes.AUTH,
      page: () => const AuthPage(),
    ),
    GetPage(
      name: AppRoutes.MAIN,
      page: () => const MainPage(),
    ),
    GetPage(
      name: AppRoutes.RECORD,
      page: () => const RecordPage(),
    ),
    GetPage(
      name: AppRoutes.FAVORITE,
      page: () => const FavoritePage(),
    ),
    GetPage(
      name: AppRoutes.RECORDER,
      page: () => const RecorderPage(),
    ),
  ];
}
