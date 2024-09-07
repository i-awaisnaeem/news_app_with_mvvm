// Your API key is: 272cbee6097848e689b2a7d21011d184
// Your API key is: a98f7b189e0548949e54bd201f7742bc

class AppUrls{

static var topHeadlinesNewsEndPoint = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=272cbee6097848e689b2a7d21011d184';

static var allSourcesNewsEndPoint = 'https://newsapi.org/v2/top-headlines/sources?apiKey=272cbee6097848e689b2a7d21011d184';

static var specificSourceNewsEndPoint = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=272cbee6097848e689b2a7d21011d184';

static String specificNewsChannelHeadlinesEndPoint(String channelName) {
  return 'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=272cbee6097848e689b2a7d21011d184';
}

static var categoryNewsEndPoint = 'https://newsapi.org/v2/everything?q=general&apiKey=a98f7b189e0548949e54bd201f7742bc';

static String specificCategoriesNewsEndPoint(String category){
  return 'https://newsapi.org/v2/everything?q=$category&apiKey=272cbee6097848e689b2a7d21011d184';
}

}