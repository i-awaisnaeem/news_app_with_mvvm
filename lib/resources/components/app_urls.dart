import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv package

class AppUrls {
  static final String _apiKeyIawais = dotenv.env['NEWS_API_KEY_IAWAIS']!;
  static final String _apiKeyIali = dotenv.env['NEWS_API_KEY_IALI']!;

  static var topHeadlinesNewsEndPoint = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKeyIawais';

  static var allSourcesNewsEndPoint = 'https://newsapi.org/v2/top-headlines/sources?apiKey=$_apiKeyIawais';

  static var specificSourceNewsEndPoint = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$_apiKeyIawais';

  static String specificNewsChannelHeadlinesEndPoint(String channelName) {
    return 'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=$_apiKeyIawais';
  }

  static var categoryNewsEndPoint = 'https://newsapi.org/v2/everything?q=general&apiKey=$_apiKeyIali';

  static String specificCategoriesNewsEndPoint(String category) {
    return 'https://newsapi.org/v2/everything?q=$category&apiKey=$_apiKeyIawais';
  }
}
