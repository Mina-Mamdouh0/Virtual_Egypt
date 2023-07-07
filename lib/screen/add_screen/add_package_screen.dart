
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/shared/widget.dart';

class AddPackageScreen extends StatelessWidget {
  AddPackageScreen({Key? key}) : super(key: key);

  final TextEditingController name=TextEditingController();
  final TextEditingController desc=TextEditingController();

  final formKey = GlobalKey<FormState>();

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
                "Add Package",
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
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      Stack(
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
                              child: cubit.file==null?Image.asset('assets/images/eyes.png',
                                fit: BoxFit.fill,):Image.file(cubit.file!,
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
                                                cubit.changeImage(picked.path);
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
                                                cubit.changeImage(picked.path);
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
                              child: Icon(cubit.file==null?Icons.camera_alt:Icons.edit,
                                color: Colors.white,
                                size: 20,),

                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),

                      defaultTextFiled(
                          controller: name,
                          inputType: TextInputType.text,
                          labelText: 'Enter the Name',
                          prefixIcon: Icons.title,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter Name';
                            }
                          }
                      ),
                      const SizedBox(height: 20,),

                      defaultTextFiled(
                          controller: desc,
                          inputType: TextInputType.text,
                          labelText: 'Enter the Desc',
                          maxLines: 4,
                          prefixIcon: Icons.description,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter Desc';
                            }
                          }
                      ),

                      const SizedBox(height: 20,),

                      (state is LoadingTripState)?
                      loadingApp()
                          :MaterialButton(
                        onPressed: (){
                          if (formKey.currentState!.validate()) {
                            if(cubit.file!=null){
                              cubit.addPackage(
                               title: name.text,
                                desc: desc.text,
                              );
                            }else{
                              successToast(msg: 'check to Chose image');
                            }
                          }else{
                            errorToast(msg: 'check Data');
                          }
                        },
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200),
                        ),
                        color: BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
                        padding: const EdgeInsets.all(15),
                        child: const Text('Add',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),


                    ],
                  ),
                ),
              ),
            ),

          );
        },
        listener: (context, state){
          if(state is SuccessTripState){
            BlocProvider.of<AppCubit>(context).file=null;
            Navigator.pop(context);
          }
        });
  }
}
