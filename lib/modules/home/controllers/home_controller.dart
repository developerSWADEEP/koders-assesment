import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/network/api_exceptions.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/post_model.dart';
import '../../../data/repositories/post_repository.dart';

enum ViewState { initial, loading, loaded, empty, error }

class HomeController extends GetxController {
  final PostRepository _postRepository = PostRepository();

  // Observable states
  final RxList<PostModel> posts = <PostModel>[].obs;
  final Rx<ViewState> viewState = ViewState.initial.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMoreData = true.obs;

  // Pagination
  int _currentPage = 0;
  final int _pageSize = AppConstants.pageSize;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 0;
      posts.clear();
      hasMoreData.value = true;
    }

    if (!hasMoreData.value && !isRefresh) return;

    viewState.value = posts.isEmpty ? ViewState.loading : viewState.value;

    try {
      final newPosts = await _postRepository.getPosts(
        start: _currentPage * _pageSize,
        limit: _pageSize,
      );

      if (newPosts.isEmpty) {
        hasMoreData.value = false;
        if (posts.isEmpty) {
          viewState.value = ViewState.empty;
        }
      } else {
        posts.addAll(newPosts);
        _currentPage++;
        viewState.value = ViewState.loaded;

        if (newPosts.length < _pageSize) {
          hasMoreData.value = false;
        }
      }
    } on NetworkException {
      errorMessage.value = 'No internet connection. Please try again.';
      viewState.value = ViewState.error;
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      viewState.value = ViewState.error;
    } catch (e) {
      errorMessage.value = 'Something went wrong. Please try again.';
      viewState.value = ViewState.error;
    }
  }

  Future<void> refreshPosts() async {
    await fetchPosts(isRefresh: true);
  }

  Future<void> loadMorePosts() async {
    if (isLoadingMore.value || !hasMoreData.value) return;

    isLoadingMore.value = true;

    try {
      final newPosts = await _postRepository.getPosts(
        start: _currentPage * _pageSize,
        limit: _pageSize,
      );

      if (newPosts.isEmpty) {
        hasMoreData.value = false;
      } else {
        posts.addAll(newPosts);
        _currentPage++;

        if (newPosts.length < _pageSize) {
          hasMoreData.value = false;
        }
      }
    } catch (e) {
      Helpers.showErrorSnackbar(message: 'Failed to load more posts');
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> deletePost(int postId) async {
    final confirmed = await Helpers.showConfirmDialog(
      title: 'Delete Post',
      message: 'Are you sure you want to delete this post?',
      confirmText: 'Delete',
      cancelText: 'Cancel',
    );

    if (confirmed != true) return;

    try {
      Helpers.showLoading(message: 'Deleting...');
      await _postRepository.deletePost(postId);
      posts.removeWhere((post) => post.id == postId);
      Helpers.hideLoading();
      Helpers.showSuccessSnackbar(message: 'Post deleted successfully');
    } catch (e) {
      Helpers.hideLoading();
      Helpers.showErrorSnackbar(message: 'Failed to delete post');
    }
  }
}

