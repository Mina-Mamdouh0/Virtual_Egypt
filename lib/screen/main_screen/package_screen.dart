



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/model/package_model.dart';
import 'package:virtual_egypt/screen/main_screen/home_screen.dart';

class PackageScreen extends StatelessWidget {
  final PackageModel packageModel;
  const PackageScreen({Key? key, required this.packageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
          foregroundColor: Colors.grey.shade900,
          centerTitle: true,
          title:  Text(
            packageModel.title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white,),
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
            height: double.infinity,
            width: double.infinity,
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(packageModel.image,width: double.infinity,height: 300,),
                  const SizedBox(height: 10,),
                  Text(packageModel.desc,style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20,),
                  (BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Admin' && FirebaseAuth.instance.currentUser?.uid==packageModel.userId)?
                  MaterialButton(
                      onPressed: (){
                        FirebaseFirestore.instance.collection('Packages').doc(packageModel.id).delete();

                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      minWidth: double.infinity,
                      color: BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
                      padding: const EdgeInsets.all(15),
                      child: const Text('Deleted',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)):Container(),
                  const SizedBox(height: 20,)
                ],
              ),
            ),

          );
        },));
  }
}
