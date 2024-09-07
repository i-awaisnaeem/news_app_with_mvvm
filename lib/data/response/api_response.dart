
import 'package:news_app_flutter/data/response/status.dart';

class ApiResponse<T>{

  // Properties
  Status? status;
  T? data;
  String? message;

  // Constructor
  ApiResponse({this.status, this.data,this.message});

  // Objects
  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;


  //Override the default toString() method for customization
  @override
  String toString(){
  return 'Status : $status \n Message : $message \n Data : $data';
  }
}