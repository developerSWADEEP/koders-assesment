import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/repositories/post_repository.dart';
import '../../home/controllers/home_controller.dart';

class CreatePostController extends GetxController {
  final PostRepository _postRepository = PostRepository();

  // Form controllers
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Observable states
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    titleController.dispose();
    bodyController.dispose();
    super.onClose();
  }

  Future<void> createPost() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final newPost = await _postRepository.createPost(
        title: titleController.text.trim(),
        body: bodyController.text.trim(),
        userId: 1, // Mock user ID
      );

      // Add to home controller list
      final homeController = Get.find<HomeController>();
      homeController.posts.insert(0, newPost);

      Helpers.showSuccessSnackbar(
        message: 'Your post has been created successfully!',
        title: 'Post Created',
      );

      Get.back();
    } catch (e) {
      Helpers.showErrorSnackbar(
        message: 'Failed to create post. Please try again.',
        title: 'Error',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    titleController.clear();
    bodyController.clear();
  }
}

