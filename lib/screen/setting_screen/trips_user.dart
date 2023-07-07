
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/model/ticket_model.dart';
import 'package:virtual_egypt/shared/widget.dart';

class TripsUserScreen extends StatelessWidget {
   TripsUserScreen({Key? key}) : super(key: key);

  CollectionReference trips = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Tickets');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
        foregroundColor: Colors.grey.shade900,
        centerTitle: true,
        title:  const Text(
          "Trips",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white,),
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
                                  child: Image.network(tripList[index].tripUserImage,fit: BoxFit.fill,
                                      height: 70,width: 70),
                                ),
                                const SizedBox(width: 20,),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(tripList[index].tripUserName,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w700 ,color: Colors.white),),
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
                            Center(child: Text( tripList[index].stutes,)),
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
