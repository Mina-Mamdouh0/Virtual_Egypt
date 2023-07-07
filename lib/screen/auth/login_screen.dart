
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/screen/layout_screen.dart';
import 'package:virtual_egypt/shared/constent.dart';
import 'package:virtual_egypt/shared/widget.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final TextEditingController email=TextEditingController();

   final TextEditingController password=TextEditingController();

   GlobalKey<FormState>kForm=GlobalKey<FormState>();

   @override
  void initState() {
     requestPermission();

    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit,AppState>(
         builder: (context,state){
           var cubit=AppCubit.get(context);
           return Container(
             height: double.infinity,
             width: double.infinity,
             decoration: BoxDecoration(
               gradient: LinearGradient(
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                   colors: [
                     BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF222B32):const Color(0XFF000000).withOpacity(0.87),
                     BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF2A6A98):const Color(0XFF000000).withOpacity(0.87),
                     BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF2D85C4):const Color(0XFFFFA437).withOpacity(0.87),
                   ]
               ),
             ),
             child: SingleChildScrollView(
               padding: const EdgeInsets.all(20.0),
               child: Form(
                 key: kForm,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     const SizedBox(height: 100,),
                     Image.asset(ConstantImage.eyesImage),
                     const SizedBox(height: 20,),
                     defaultTextFiled(
                         controller: email,
                         inputType: TextInputType.emailAddress,
                         labelText: 'Enter your email ',
                         prefixIcon: Icons.email,
                         validator: (val){
                           if(val!.isEmpty){
                             return 'Please Enter The Email';
                           }
                       }
                     ),

                     const SizedBox(height: 20,),
                     defaultTextFiled(
                         controller: password,
                         inputType: TextInputType.text,
                         labelText: 'Enter your password  ',
                         prefixIcon: Icons.lock,
                         obscureText: cubit.obscureText,
                         suffixIcon: cubit.obscureText?Icons.visibility:Icons.visibility_off,
                         onTapSuffix: ()=>cubit.visiblePassword(),
                         validator: (val){
                           if(val!.isEmpty){
                             return 'Please Enter The Password';
                           }
                         }
                     ),
                     const SizedBox(height: 30,),

                     (state is LoadingLoginScreen)?
                     loadingApp():
                     MaterialButton(
                       onPressed: (){
                         if(kForm.currentState!.validate()){
                           cubit.userLogin(email: email.text,
                               password: password.text);
                         }
                       },
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(200),
                       ),
                       color: BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
                       padding: const EdgeInsets.all(15),
                       child: const Text('LOGIN',
                         style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),
                     const SizedBox(height: 30,),
                   ],
                 ),
               ),
             ),
           );
         },
        listener: (context,state)async{
           if(state is SuccessLoginScreen){
             successToast(msg: 'Success Login');
             await FirebaseMessaging.instance.getToken().then(
                     (token)async {
                   await FirebaseFirestore.instance.collection("UserTokens").doc(FirebaseAuth.instance.currentUser!.uid).set({
                     'token' : token,
                   });
                 }
             );
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
           }else if(state is ErrorLoginScreen){
             errorToast(msg: 'Not Login Try Again');
           }

        },
      )
    );
  }
}
