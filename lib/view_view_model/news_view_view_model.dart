
import 'package:flutter/cupertino.dart';
import 'package:news_app_flutter/data/response/api_response.dart';
import 'package:news_app_flutter/models/news_channel_headlines_model.dart';
import 'package:news_app_flutter/repository/news_repository.dart';

// ViewModel class for managing the state of the news view
class NewsViewViewModel with ChangeNotifier{

  // Private instance of NewsRepository to fetch data from the API
  final NewsRepository _myRepo = NewsRepository();

  // ApiResponse object to manage the state of the news list data
  ApiResponse<NewsChannelHeadlinesModel> newsList = ApiResponse.loading();

  // Method to update the newsList state and notify listeners
  setNewsList(ApiResponse<NewsChannelHeadlinesModel> response) {
    newsList = response;
    notifyListeners();
  }

  // Method to fetch news channel headlines from the API
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async {
    setNewsList(ApiResponse.loading());

    try {
      // Await the repository method to fetch data
      NewsChannelHeadlinesModel newsHeadlines = await _myRepo.fetchNewsChannelHeadlinesApi(channelName);
      setNewsList(ApiResponse.completed(newsHeadlines));
      return newsHeadlines; // Explicitly return the fetched data
    }
    catch (error) {
      setNewsList(ApiResponse.error(error.toString()));
      throw Exception(
          "Failed to fetch news headlines: $error"); // Explicitly throw an exception
    }
  }
}
