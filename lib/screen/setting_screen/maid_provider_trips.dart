
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/model/ticket_model.dart';
import 'package:virtual_egypt/shared/widget.dart';

class MaidTripsScreen extends StatefulWidget {
  const MaidTripsScreen({Key? key}) : super(key: key);

  @override
  State<MaidTripsScreen> createState() => _MaidTripsScreenState();
}

class _MaidTripsScreenState extends State<MaidTripsScreen> {

  String? mtoken = " ";
  @override
  void initState() {
    super.initState();

    requestPermission();

    loadFCM();

    listenFCM();

    FirebaseMessaging.instance.subscribeToTopic("Animal");
  }
  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAM6MdFo4:APA91bHT1r4_WpYYAR8HmkMxhSqXnGRSv4liYuMtqgchDalYXsZljglRPL_sOcTJ7j8qKGT4PrZLnAGZji3zdGCs0taR2Ui7v-ogvWV7eMBYIkItCIX0oXp-CwkTmeHfDW4ipGjzIv4u',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }
  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  CollectionReference trips = FirebaseFirestore.instance.collection('Users').
  doc(FirebaseAuth.instance.currentUser!.uid).collection('Tickets');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
        foregroundColor: Colors.grey.shade900,
        centerTitle: true,
        title:  Text(
          "Trips",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.grey.shade900,),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,color: Colors.white),
        ),
      ),
      body: BlocBuilder<AppCubit,AppState>(builder: (context,state){
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF2A6A98):const Color(0XFF000000).withOpacity(0.87),
                  BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF2D85C4):const Color(0XFFFFA437).withOpacity(0.87),
                ]
            ),
          ),
          child: StreamBuilder(
              stream: trips.orderBy('CreateAt',descending: true).snapshots(),
              builder: (context,snapShot){
                if(snapShot.connectionState==ConnectionState.waiting){
                  return loadingApp();
                }else if (snapShot.hasError){
                  return loadingApp();
                }
                if(snapShot.hasData){
                  List<TicketModel> tripList=[];
                  for(int i=0;i<snapShot.data!.docs.length;i++){
                    tripList.add(TicketModel.jsonData(snapShot.data!.docs[i]));
                  }
                  return ListView.separated(
                    itemCount: tripList.length,
                    itemBuilder: (context,index){
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                        margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(tripList[index].userImage,fit: BoxFit.fill,
                                      height: 70,width: 70),
                                ),
                                const SizedBox(width: 20,),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(tripList[index].userName,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w700 ,color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height:30,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.circle,size: 16,color: Color(0XFFAEBBC6),),
                                    FDottedLine(
                                      color: const Color(0XFF707070),
                                      height: 50,
                                      strokeWidth: 2.0,
                                      dottedLength: 1.0,
                                      space: 5.0,
                                    ),
                                    const Icon(Icons.circle,size: 16,color:Color(0XFFFFA437),),
                                  ],
                                ),
                                const SizedBox(width: 30,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      const Text('Pick up',style: TextStyle(fontSize: 12 ,color: Color(0XFFAAAAAA),)),
                                      const SizedBox(height: 10,),
                                      Text(tripList[index].pickUpGo,style: const TextStyle(fontSize: 13 ,color: Colors.white,)),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(height: 30,),

                            const SizedBox(height: 15,),
                            tripList[index].stutes!=''?
                            Center(child: Text( tripList[index].stutes,style: TextStyle(color: Colors.white),)):
                            MaterialButton(
                              onPressed: (){

                                FirebaseFirestore.instance.collection("UserTokens").doc(tripList[index].userId).get()
                                    .then((value){
                                  setState(() {
                                    mtoken = value.get('token');
                                  });
                                });
                                sendPushMessage(mtoken??'','Accepted','Accepted To Trips');

                                TicketModel ticketModel=TicketModel(
                                  createAt: tripList[index].createAt,
                                  pickUpGo:tripList[index].pickUpGo,
                                  tripUserId:tripList[index].userId,
                                  userId:tripList[index].userId,
                                  stutes: 'Accepted',
                                  tripId: tripList[index].tripId,
                                  tripUserImage: tripList[index].userImage,
                                  tripUserName: tripList[index].userImage,
                                  userName: tripList[index].userName,
                                  userImage: tripList[index].userImage,
                                );


                                FirebaseFirestore.instance.collection('Users').doc(tripList[index].userId).collection('Tickets')
                                    .doc(tripList[index].tripId).set(ticketModel.toMap());

                                FirebaseFirestore.instance.collection('Users').doc(tripList[index].tripUserId).collection('Tickets')
                                    .doc(tripList[index].tripId).set(ticketModel.toMap());
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              minWidth: double.infinity,
                              color: const Color(0XFF4D3212),
                              padding: const EdgeInsets.all(15),
                              child: const Text('Accepted',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),
                            const SizedBox(height: 10,),
                            tripList[index].stutes!=''?
                            Container():
                            MaterialButton(
                              onPressed: (){
                                FirebaseFirestore.instance.collection('Users').doc(tripList[index].userId).collection('Tickets')
                                    .doc(tripList[index].tripId).delete();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              minWidth: double.infinity,
                              color: BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
                              padding: const EdgeInsets.all(15),
                              child: const Text('Rejected',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),
                            const SizedBox(height: 10,),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context,index){
                      return const SizedBox(
                        width: double.infinity,
                        height: 3,
                      );
                    },
                  );
                }else{
                  return loadingApp();
                }
              }),

        );
      },)

    );
  }
}
