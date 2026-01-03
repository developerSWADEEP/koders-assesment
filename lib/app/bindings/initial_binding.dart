import 'package:get/get.dart';
import '../../core/network/api_client.dart';
import '../../data/services/storage_service.dart';
import '../../modules/auth/controllers/auth_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core Services
    Get.put<ApiClient>(ApiClient(), permanent: true);
    
    // Auth Controller (global)
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}

