import 'package:get/get.dart';
import '../../../core/network/api_exceptions.dart';
import '../../../data/models/post_model.dart';
import '../../../data/repositories/post_repository.dart';

enum DetailState { loading, loaded, error }

class DetailController extends GetxController {
  final PostRepository _postRepository = PostRepository();

  // Observable states
  final Rxn<PostModel> post = Rxn<PostModel>();
  final RxList<CommentModel> comments = <CommentModel>[].obs;
  final Rx<DetailState> viewState = DetailState.loading.obs;
  final RxBool isLoadingComments = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPostData();
  }

  void _loadPostData() {
    final args = Get.arguments;
    if (args is PostModel) {
      post.value = args;
      viewState.value = DetailState.loaded;
      fetchComments();
    } else if (args is int) {
      fetchPostById(args);
    } else {
      errorMessage.value = 'Invalid post data';
      viewState.value = DetailState.error;
    }
  }

  Future<void> fetchPostById(int id) async {
    viewState.value = DetailState.loading;

    try {
      final fetchedPost = await _postRepository.getPostById(id);
      post.value = fetchedPost;
      viewState.value = DetailState.loaded;
      fetchComments();
    } on NetworkException {
      errorMessage.value = 'No internet connection';
      viewState.value = DetailState.error;
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      viewState.value = DetailState.error;
    } catch (e) {
      errorMessage.value = 'Failed to load post details';
      viewState.value = DetailState.error;
    }
  }

  Future<void> fetchComments() async {
    if (post.value == null) return;

    isLoadingComments.value = true;

    try {
      final fetchedComments = await _postRepository.getCommentsByPostId(post.value!.id);
      comments.assignAll(fetchedComments);
    } catch (e) {
      // Silently fail for comments, they're not critical
    } finally {
      isLoadingComments.value = false;
    }
  }

  Future<void> refreshPost() async {
    if (post.value != null) {
      await fetchPostById(post.value!.id);
    }
  }
}

