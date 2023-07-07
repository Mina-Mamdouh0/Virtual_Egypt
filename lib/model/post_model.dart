
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel{
  String? post;
  final String postId;
  final String userId;
  final String userImage;
  final String userName;
  String? image;
  final Timestamp dateTime;
  final List likes;


  PostModel({this.post,required this.userId, this.image,required this.dateTime,required this.userImage,required this.userName,
   required this.postId,
    required this.likes});

  factory PostModel.formJson(json,){
    return PostModel(
      post: json['Post'],
      userId:json['UserId'],
      image: json['Image'],
      dateTime: json['DateTime'],
      userImage: json['UserImage'],
      userName: json['UserName'],
      postId: json['PostId'],
      likes: json['Likes'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Post': post,
      'UserId':userId,
      'Image': image,
      'DateTime': dateTime,
      'UserImage': userImage,
      'UserName': userName,
      'PostId':postId,
      'Likes':likes,
    };

  }



}