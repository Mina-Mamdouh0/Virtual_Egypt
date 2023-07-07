
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/shared/widget.dart';

class AddAdsScreen extends StatelessWidget {
   AddAdsScreen({Key? key}) : super(key: key);
   final TextEditingController controller =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context, state) {
          var cubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor:BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
              foregroundColor: Colors.grey.shade900,
              centerTitle: true,
              title:  const Text(
                "Add Ads",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white,),
              ),
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                  cubit.file=null;
                },
                icon: const Icon(Icons.arrow_back,color: Colors.white),
              ),
            ),
            body: Container(
              height: double.infinity,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),

                    Row(
                      children: [
                        Expanded(child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              margin:const  EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.width*0.2,
                              width: MediaQuery.of(context).size.width*0.2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: cubit.image1Ads==null?Image.asset('assets/images/eyes.png',
                                  fit: BoxFit.fill,):Image.file(cubit.image1Ads!,
                                  fit: BoxFit.fill,),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                showDialog(context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title:const  Text(
                                          'Choose Image',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: ()async{
                                                Navigator.pop(context);
                                                XFile? picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                                if(picked !=null){
                                                  cubit.showImage1Ads(image: File(picked.path));
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: const [
                                                    Icon(Icons.photo,color: Colors.orange,),
                                                    SizedBox(width: 10,),
                                                    Text('Camera',
                                                      style: TextStyle(
                                                          color: Colors.orange,fontSize: 20
                                                      ),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: ()async{
                                                Navigator.pop(context);
                                                XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                                if(picked !=null){
                                                  cubit.showImage1Ads(image: File(picked.path));
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: const [
                                                    Icon(Icons.camera,color: Colors.orange,),
                                                    SizedBox(width: 10,),
                                                    Text('Gallery',
                                                      style: TextStyle(
                                                          color: Colors.orange,fontSize: 20
                                                      ),)
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 2,
                                        color: Colors.white),
                                    color: Colors.pink
                                ),
                                child: Icon(cubit.image1Ads==null?Icons.camera_alt:Icons.edit,
                                  color: Colors.white,
                                  size: 20,),

                              ),
                            )
                          ],
                        ),),
                        Expanded(child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              margin:const  EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.width*0.2,
                              width: MediaQuery.of(context).size.width*0.2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: cubit.image2Ads==null?Image.asset('assets/images/eyes.png',
                                  fit: BoxFit.fill,):Image.file(cubit.image2Ads!,
                                  fit: BoxFit.fill,),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                showDialog(context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title:const  Text(
                                          'Choose Image',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: ()async{
                                                Navigator.pop(context);
                                                XFile? picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                                if(picked !=null){
                                                  cubit.showImage2Ads(image: File(picked.path));
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: const [
                                                    Icon(Icons.photo,color: Colors.orange,),
                                                    SizedBox(width: 10,),
                                                    Text('Camera',
                                                      style: TextStyle(
                                                          color: Colors.orange,fontSize: 20
                                                      ),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: ()async{
                                                Navigator.pop(context);
                                                XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                                if(picked !=null){
                                                  cubit.showImage2Ads(image: File(picked.path));
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: const [
                                                    Icon(Icons.camera,color: Colors.orange,),
                                                    SizedBox(width: 10,),
                                                    Text('Gallery',
                                                      style: TextStyle(
                                                          color: Colors.orange,fontSize: 20
                                                      ),)
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 2,
                                        color: Colors.white),
                                    color: Colors.pink
                                ),
                                child: Icon(cubit.image2Ads==null?Icons.camera_alt:Icons.edit,
                                  color: Colors.white,
                                  size: 20,),

                              ),
                            )
                          ],
                        ),),
                        Expanded(child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              margin:const  EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.width*0.2,
                              width: MediaQuery.of(context).size.width*0.2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: cubit.image3Ads==null?Image.asset('assets/images/eyes.png',
                                  fit: BoxFit.fill,):Image.file(cubit.image3Ads!,
                                  fit: BoxFit.fill,),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                showDialog(context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title:const  Text(
                                          'Choose Image',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: ()async{
                                                Navigator.pop(context);
                                                XFile? picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                                if(picked !=null){
                                                  cubit.showImage3Ads(image: File(picked.path));
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: const [
                                                    Icon(Icons.photo,color: Colors.orange,),
                                                    SizedBox(width: 10,),
                                                    Text('Camera',
                                                      style: TextStyle(
                                                          color: Colors.orange,fontSize: 20
                                                      ),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: ()async{
                                                Navigator.pop(context);
                                                XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                                if(picked !=null){
                                                  cubit.showImage3Ads(image: File(picked.path));
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: const [
                                                    Icon(Icons.camera,color: Colors.orange,),
                                                    SizedBox(width: 10,),
                                                    Text('Gallery',
                                                      style: TextStyle(
                                                          color: Colors.orange,fontSize: 20
                                                      ),)
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 2,
                                        color: Colors.white),
                                    color: Colors.pink
                                ),
                                child: Icon(cubit.image3Ads==null?Icons.camera_alt:Icons.edit,
                                  color: Colors.white,
                                  size: 20,),

                              ),
                            )
                          ],
                        ),),
                      ],
                    ),

                    const SizedBox(height: 10,),

                    defaultTextFiled(
                        controller: controller,
                        inputType: TextInputType.text,
                        labelText: 'Enter the Ads',
                        prefixIcon: Icons.person_2,
                        validator: (val){
                          if(val!.isEmpty){
                            return 'Please Enter The Ads';
                          }
                        }
                    ),
                    const SizedBox(height: 20,),


                    (state is LoadingAdsState)?
                    loadingApp()
                        :MaterialButton(
                      onPressed: (){
                          if(cubit.image1Ads!=null && cubit.image2Ads!=null && cubit.image3Ads!=null && controller.text.isNotEmpty){
                            cubit.addAdsApp(adsText: controller.text);
                          }else{
                            successToast(msg: 'check to Full Data');
                          }
                      },
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      color: BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
                      padding: const EdgeInsets.all(15),
                      child: const Text('Add Ads',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),


                  ],
                ),
              ),
            ),

          );
        },
        listener: (context, state){
          if(state is SuccessAdsState){
            BlocProvider.of<AppCubit>(context).image1Ads=null;
            BlocProvider.of<AppCubit>(context).image2Ads=null;
            BlocProvider.of<AppCubit>(context).image3Ads=null;
            Navigator.of(context).pop();
          }else if(state is ErrorAdsState){
            Fluttertoast.showToast(msg: 'Error in Ads');
            BlocProvider.of<AppCubit>(context).image1Ads=null;
            BlocProvider.of<AppCubit>(context).image2Ads=null;
            BlocProvider.of<AppCubit>(context).image3Ads=null;
            Navigator.of(context).pop();
          }
        });
  }
}
