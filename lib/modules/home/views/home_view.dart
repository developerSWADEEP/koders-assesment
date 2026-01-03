import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/helpers.dart';
import '../../../modules/auth/controllers/auth_controller.dart';
import '../../../shared/widgets/empty_widget.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../controllers/home_controller.dart';
import 'widgets/post_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Obx(() => _buildBody()),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Helpers.getGreeting(),
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const Text(
            'Posts Feed',
            style: AppTextStyles.h5,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => Get.toNamed(AppRoutes.createPost),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.primary,
              size: 22,
            ),
          ),
        ),
        PopupMenuButton<String>(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.more_vert,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (value) {
            if (value == 'logout') {
              Get.find<AuthController>().logout();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'profile',
              child: Row(
                children: [
                  const Icon(Icons.person_outline, size: 20),
                  const SizedBox(width: 12),
                  Text('Profile', style: AppTextStyles.bodyMedium),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'settings',
              child: Row(
                children: [
                  const Icon(Icons.settings_outlined, size: 20),
                  const SizedBox(width: 12),
                  Text('Settings', style: AppTextStyles.bodyMedium),
                ],
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              value: 'logout',
              child: Row(
                children: [
                  const Icon(Icons.logout, size: 20, color: AppColors.error),
                  const SizedBox(width: 12),
                  Text(
                    'Logout',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBody() {
    switch (controller.viewState.value) {
      case ViewState.loading:
        return const LoadingWidget(message: 'Loading posts...');

      case ViewState.error:
        return CustomErrorWidget(
          title: 'Oops!',
          message: controller.errorMessage.value,
          onRetry: controller.refreshPosts,
        );

      case ViewState.empty:
        return EmptyWidget(
          title: 'No Posts Yet',
          message: 'There are no posts to display. Pull down to refresh.',
          icon: Icons.article_outlined,
          actionText: 'Refresh',
          onAction: controller.refreshPosts,
        );

      case ViewState.loaded:
      case ViewState.initial:
        return _buildPostsList();
    }
  }

  Widget _buildPostsList() {
    return RefreshIndicator(
      onRefresh: controller.refreshPosts,
      color: AppColors.primary,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 200) {
              controller.loadMorePosts();
            }
          }
          return false;
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.posts.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.posts.length) {
              return _buildLoadMoreIndicator();
            }

            final post = controller.posts[index];
            return PostCard(
              post: post,
              onTap: () => Get.toNamed(
                AppRoutes.postDetail,
                arguments: post,
              ),
              onDelete: () => controller.deletePost(post.id),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return Obx(() {
      if (controller.isLoadingMore.value) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          ),
        );
      }

      if (!controller.hasMoreData.value && controller.posts.isNotEmpty) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              'You\'ve reached the end!',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        );
      }

      return const SizedBox.shrink();
    });
  }
}

