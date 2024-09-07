import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:news_app_flutter/data/app_exceptions.dart';
import 'package:news_app_flutter/data/network/BaseApiServices.dart';

class NetworkApiServices extends BaseApiServices{

  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;   // Variable to store the parsed JSON response
    try{
        final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
        responseJson = returnResponse(response);
    }on SocketException{
        throw FetchDataException('No Internet Connection');
    }
  return responseJson;
  }
}

dynamic returnResponse(http.Response response){
  switch(response.statusCode){

    case 200:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;

    case 400:
      throw BadRequestException(response.body.toString());

    case 404:
      throw UnautorisedException(response.body.toString());

    case 429:
      throw UnautorisedException(response.body.toString());

    default:
      throw FetchDataException('Error occured while communicating with server' +
      'with status code ' + response.statusCode.toString());
  }
}