import 'package:get/get.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_exceptions.dart';
import '../models/post_model.dart';

class PostRepository {
  final ApiClient _apiClient = Get.find<ApiClient>();

  // Get all posts with pagination
  Future<List<PostModel>> getPosts({int? start, int? limit}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (start != null) queryParams['_start'] = start;
      if (limit != null) queryParams['_limit'] = limit;

      final response = await _apiClient.get(
        ApiConstants.posts,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      if (response.data is List) {
        return (response.data as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
      }

      return [];
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Failed to fetch posts');
    }
  }

  // Get single post by ID
  Future<PostModel> getPostById(int id) async {
    try {
      final response = await _apiClient.get('${ApiConstants.posts}/$id');

      return PostModel.fromJson(response.data);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Failed to fetch post details');
    }
  }

  // Get posts by user ID
  Future<List<PostModel>> getPostsByUserId(int userId) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.posts,
        queryParameters: {'userId': userId},
      );

      if (response.data is List) {
        return (response.data as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
      }

      return [];
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Failed to fetch user posts');
    }
  }

  // Get comments for a post
  Future<List<CommentModel>> getCommentsByPostId(int postId) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.posts}/$postId${ApiConstants.comments}',
      );

      if (response.data is List) {
        return (response.data as List)
            .map((json) => CommentModel.fromJson(json))
            .toList();
      }

      return [];
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Failed to fetch comments');
    }
  }

  // Create a new post
  Future<PostModel> createPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.posts,
        data: {
          'title': title,
          'body': body,
          'userId': userId,
        },
      );

      return PostModel.fromJson(response.data);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Failed to create post');
    }
  }

  // Update a post
  Future<PostModel> updatePost(int id, {String? title, String? body}) async {
    try {
      final data = <String, dynamic>{};
      if (title != null) data['title'] = title;
      if (body != null) data['body'] = body;

      final response = await _apiClient.put(
        '${ApiConstants.posts}/$id',
        data: data,
      );

      return PostModel.fromJson(response.data);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Failed to update post');
    }
  }

  // Delete a post
  Future<void> deletePost(int id) async {
    try {
      await _apiClient.delete('${ApiConstants.posts}/$id');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Failed to delete post');
    }
  }
}

