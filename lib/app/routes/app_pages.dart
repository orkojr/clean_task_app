
import 'package:get/get.dart';
import 'package:clean_task_app/presentation/pages/task_home_page.dart';

part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const TaskHomePage(),
    ),
  ];
}
