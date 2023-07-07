
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketModel{
  final String tripUserId;
  final String userId;
  final String userName;
  final String userImage;
  final String tripUserName;
  final String tripUserImage;
  final String pickUpGo;
  final String tripId;
  final String stutes;
  final Timestamp createAt;

  TicketModel(
      {required this.userId,required this.userName,required this.userImage,required this.pickUpGo,required this.createAt,
      required this.stutes, required this.tripUserId, required this.tripUserImage, required this.tripUserName,required this.tripId});

  factory TicketModel.jsonData(data){
    return TicketModel(
      tripUserName: data['TripUserName'],
      createAt: data['CreateAt'],
      userImage: data['UserImage'],
      userName: data['UserName'],
      userId: data['UserId'],
      tripUserImage: data['TripUserImage'],
      tripUserId: data['TripUserId'],
      stutes: data['Stutes'],
      tripId: data['TripId'],
      pickUpGo: data['PickUpGo'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'UserImage':userImage,
      'UserName':userName,
      'UserId':userId,
      'CreateAt':createAt,
      'TripUserName':tripUserName,
      'TripUserImage':tripUserImage,
      'TripUserId':tripUserId,
      'Stutes':stutes,
      'PickUpGo':pickUpGo,
      'TripId':tripId,
    };
  }


}