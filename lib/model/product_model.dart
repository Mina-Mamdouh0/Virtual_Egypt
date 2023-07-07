
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  final String title;
  final String productId;
  final String userId;
  final String image;
  final String image1;
  final String image2;
  final String image3;
  final String userImage;
  final String userName;
  final String userPhone;
  final String price;
  final String desc;
  final String rate;
  final List likes;
  final Timestamp dateTime;


  ProductModel({required this.image,required this.userName,required this.userImage,
  required this.dateTime,required this.userId,required this.title,
  required this.price,required this.desc,required this.image1,required this.image2,required this.image3,
  required this.productId,required this.rate,required this.userPhone,required this.likes});

  factory ProductModel.formJson(json,){
    return ProductModel(
      userPhone: json['UserPhone'],
      rate: json['Rate'],
      productId: json['ProductId'],
      image3: json['Image3'],
      image2: json['Image2'],
      image1: json['Image1'],
      desc: json['Desc'],
      price: json['Price'],
      title: json['Title'],
      userId: json['UserId'],
      dateTime: json['DateTime'],
      userImage: json['UserImage'],
      userName: json['UserName'],
      image: json['Image'],
      likes: json['Likes'],
    );
  }
  Map<String,dynamic> toMap(){
    return {
      'DateTime':dateTime,
      'UserImage':userImage,
      'UserName':userName,
      'Image':image,
      'UserPhone':userPhone,
      'Rate':rate,
      'ProductId':productId,
      'Image3':image3,
      'Image2':image2,
      'Image1':image1,
      'Desc':desc,
      'Price':price,
      'Title':title,
      'UserId':userId,
      'Likes':likes
    };
  }

}