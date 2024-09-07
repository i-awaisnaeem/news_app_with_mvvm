
// This repo will fetch back Api Data

import 'package:flutter/foundation.dart';
import 'package:news_app_flutter/data/network/BaseApiServices.dart';
import 'package:news_app_flutter/data/network/NetworkApiServices.dart';
import 'package:news_app_flutter/models/categories_news_model.dart';
import 'package:news_app_flutter/models/news_channel_headlines_model.dart';
import 'package:news_app_flutter/resources/components/app_urls.dart';

class NewsRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async{
    try{
      // Make an API call to fetch news channel headlines using the specific endpoint URL
      dynamic response = await _apiServices.getApiResponse(AppUrls.specificNewsChannelHeadlinesEndPoint(channelName));
       /* if (kDebugMode){
          print(response.toString());
          print('Api Hit');
        } */
      // Parse the response JSON into a NewsChannelHeadlinesModel object and return it
      return NewsChannelHeadlinesModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

  Future<CategoriesNewsModel> fetchCategoryNewsApi(String category) async{
    try{
      // Make an API call to fetch Category news using the specific endpoint URL
      dynamic response = await _apiServices.getApiResponse(AppUrls.specificCategoriesNewsEndPoint(category));
     /* if (kDebugMode){
        print(response.toString());
        print('Api Hit');
      } */
      // Parse the response JSON into a NewsChannelHeadlinesModel object and return it
      return CategoriesNewsModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

}