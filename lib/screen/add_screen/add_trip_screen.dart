
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/shared/widget.dart';

class AddTripScreen extends StatelessWidget {
  AddTripScreen({Key? key}) : super(key: key);

  final TextEditingController pickUpGo=TextEditingController();
  final TextEditingController dropOffGo=TextEditingController();

  final TextEditingController pickUpWant=TextEditingController();
  final TextEditingController dropOffWant=TextEditingController();

  final TextEditingController total=TextEditingController();
  final TextEditingController dateTrip=TextEditingController();

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
                "Add Trip",
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
                          controller: pickUpGo,
                          inputType: TextInputType.text,
                          labelText: 'Enter the Pick Up Go',
                          prefixIcon: Icons.location_city,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter The Pick Up Go';
                            }
                          }
                      ),
                      const SizedBox(height: 20,),

                      defaultTextFiled(
                          controller: dropOffGo,
                          inputType: TextInputType.text,
                          labelText: 'Enter the Drop Off Go',
                          prefixIcon: Icons.location_city,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter The Drop Off Go';
                            }
                          }
                      ),
                      const SizedBox(height: 20,),

                      defaultTextFiled(
                          controller: pickUpWant,
                          inputType: TextInputType.text,
                          labelText: 'Enter the Pick Up Want',
                          prefixIcon: Icons.location_city,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter The Pick Up Want';
                            }
                          }
                      ),
                      const SizedBox(height: 20,),

                      defaultTextFiled(
                          controller: dropOffWant,
                          inputType: TextInputType.text,
                          labelText: 'Enter the Drop Off Want',
                          prefixIcon: Icons.location_city,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter The Drop Off Want';
                            }
                          }
                      ),
                      const SizedBox(height: 20,),

                      defaultTextFiled(
                          controller: total,
                          inputType: TextInputType.number,
                          inputFormatters:<TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.deny(RegExp(r'^0+(?=.)')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          labelText: 'Enter the Total',
                          prefixIcon: Icons.monetization_on_outlined,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Please Enter The Total';
                            }
                          }
                      ),
                      const SizedBox(height: 20,),

                      TextFormField(
                        controller: dateTrip,
                        keyboardType: TextInputType.text,
                        readOnly: true,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w400,
                            fontSize: 20
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'must not be empty';
                          }
                          return null;
                        },
                        onTap: (){
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030)
                          ).then((value) {
                            if(value!=null){
                              dateTrip.text='${value.year}-${value.month}-${value.day}';
                            }
                          });
                        },
                        decoration: InputDecoration(
                          labelText: ("B-Date"),
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w400,
                              fontSize: 20
                          ),
                          fillColor:Colors.white.withOpacity(0.6),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(200),
                              borderSide:  const BorderSide(
                                color:Color(0XFFFFA437),
                                width: 0.5,
                              )
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(200),
                              borderSide: const BorderSide(
                                color:  Colors.red,
                                width: 1,
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(200),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              )
                          ),
                          prefixIcon:  Icon(Icons.calendar_today,color: Colors.black.withOpacity(0.92)),
                        ),
                      ),
                      const SizedBox(height: 20,),

                      const SizedBox(height: 20,),

                      (state is LoadingTripState)?
                       loadingApp()
                          :MaterialButton(
                        onPressed: (){
                          if (formKey.currentState!.validate()) {
                            if(cubit.file!=null){
                              cubit.addTrip(
                                  total: total.text,
                                  dropOffGo: dropOffGo.text,
                                  dateTrip: dateTrip.text,
                                  dropOffWant: dropOffWant.text,
                                  pickUpGo: pickUpGo.text,
                                  pickUpWant: pickUpWant.text
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
                        child: const Text('Edit Info',
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
            Navigator.pop(context);
          }
        });
  }
}
