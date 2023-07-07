
import 'package:cloud_firestore/cloud_firestore.dart';

class PackageModel{
  final String image;
  final String userId;
  final String title;
  final String desc;
  final String phone;
  final String id;
  final Timestamp createAt;

  PackageModel(
      {required this.userId,required this.image,required this.desc,required this.createAt,
      required this.title,required this.phone,required this.id});

  factory PackageModel.jsonData(data){
    return PackageModel(
      phone: data['Phone'],
      createAt: data['CreateAt'],
      title: data['Title'],
      desc: data['Desc'],
      userId: data['UserId'],
      image: data['Image'],
      id: data['Id'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Phone':phone,
      'Title':title,
      'UserId':userId,
      'CreateAt':createAt,
      'Desc':desc,
      'Image':image,
      'Id':id
    };
  }


}