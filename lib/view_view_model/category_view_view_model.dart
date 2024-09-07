
import 'package:flutter/cupertino.dart';
import 'package:news_app_flutter/data/response/api_response.dart';
import 'package:news_app_flutter/models/categories_news_model.dart';
import 'package:news_app_flutter/repository/news_repository.dart';

// ViewModel class for managing the state of the news view
class CategoryViewViewModel with ChangeNotifier{

  // Private instance of NewsRepository to fetch data from the API
  final NewsRepository _myRepo = NewsRepository();

  // ApiResponse object to manage the state of the news list data
  ApiResponse<CategoriesNewsModel> newsList = ApiResponse.loading();

  // Method to update the newsList state and notify listeners
  setNewsList(ApiResponse<CategoriesNewsModel> response) {
    newsList = response;
    notifyListeners();
  }

  // Method to fetch news channel headlines from the API
  Future<CategoriesNewsModel> fetchCategoryNewsApi(String category) async {
    setNewsList(ApiResponse.loading());

    try {
      // Await the repository method to fetch data
      CategoriesNewsModel newsCategories = await _myRepo.fetchCategoryNewsApi(category);
      setNewsList(ApiResponse.completed(newsCategories));
      return newsCategories; // Explicitly return the fetched data
    }
    catch (error) {
      setNewsList(ApiResponse.error(error.toString()));
      throw Exception(
          "Failed to fetch news Categories: $error"); // Explicitly throw an exception
    }
  }
}
