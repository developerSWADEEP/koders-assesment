import 'package:get/get.dart';
import '../../modules/auth/bindings/auth_binding.dart';
import '../../modules/auth/views/login_view.dart';
import '../../modules/create_post/bindings/create_post_binding.dart';
import '../../modules/create_post/views/create_post_view.dart';
import '../../modules/detail/bindings/detail_binding.dart';
import '../../modules/detail/views/detail_view.dart';
import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.login;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.postDetail,
      page: () => const DetailView(),
      binding: DetailBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.createPost,
      page: () => const CreatePostView(),
      binding: CreatePostBinding(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}

