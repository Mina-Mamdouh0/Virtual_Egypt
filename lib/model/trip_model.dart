

import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel{
  final String pickUpGo;
  final String dropOffGo;
  final String pickUpWant;
  final String dropOffWant;
  final String total;
  final String dateTrip;

  final String tripId;
  final String userId;
  final String userImage;
  final String userName;
  final String rateUser;
  final String image;
  final Timestamp dateTime;



  TripModel({required this.image,required this.userId,required this.dateTrip,required this.dropOffGo,
  required this.userImage,required this.dateTime,required this.userName,required this.dropOffWant,
    required this.pickUpGo,required this.pickUpWant,required this.rateUser,required this.total,required this.tripId
  });

  factory TripModel.formJson(json,){
    return TripModel(
      tripId: json['TripId'],
      userId:json['UserId'],
      image: json['Image'],
      dateTime: json['DateTime'],
      userImage: json['UserImage'],
      userName: json['UserName'],
      total: json['Total'],
      rateUser: json['RateUser'],
      pickUpWant: json['PickUpWant'],
      pickUpGo: json['PickUpGo'],
      dropOffWant: json['DropOffWant'],
      dropOffGo: json['DropOffGo'],
      dateTrip: json['DateTrip'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'UserId':userId,
      'Image': image,
      'DateTime': dateTime,
      'UserImage': userImage,
      'UserName': userName,
      'TripId': tripId,
      'Total': total,
      'RateUser': rateUser,
      'PickUpWant': pickUpWant,
      'PickUpGo': pickUpGo,
      'DropOffWant': dropOffWant,
      'DropOffGo': dropOffGo,
      'DateTrip': dateTrip,
    };

  }



}