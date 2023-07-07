
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel{
  final String comment;
  final String userId;
  final String userName;
  final String userImage;
  final Timestamp createAt;

  CommentModel(
      {required this.userId,required this.userName,required this.userImage,required this.comment,required this.createAt,});

  factory CommentModel.jsonData(data){
    return CommentModel(
      comment: data['Comment'],
      createAt: data['CreateAt'],
      userImage: data['UserImage'],
      userName: data['UserName'],
      userId: data['UserId'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'UserImage':userImage,
      'UserName':userName,
      'UserId':userId,
      'CreateAt':createAt,
      'Comment':comment,
    };
  }


}