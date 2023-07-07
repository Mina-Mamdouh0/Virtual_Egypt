
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/screen/auth/login_screen.dart';
import 'package:virtual_egypt/screen/auth/signup_screen.dart';
import 'package:virtual_egypt/screen/layout_screen.dart';
import 'package:virtual_egypt/shared/constent.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
          return Scaffold(
            body: Container(
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Image.asset(ConstantImage.welcomeImage),

                    const Spacer(),
                    const Text('Welcome to Virtual Egypt .. You can now log in or sign up',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),textAlign: TextAlign.center,),

                    const Spacer(),

                    MaterialButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      color: BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
                      minWidth: double.infinity,
                      padding: const EdgeInsets.all(15),
                      child: const Text('LOGIN',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),

                    const SizedBox(height: 20,),

                    MaterialButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      color: Colors.white,
                      minWidth: double.infinity,
                      padding: const EdgeInsets.all(15),
                      child: const Text('SIGN UP',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),),

                    const SizedBox(height: 20,),

                    MaterialButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      color: Colors.white,
                      minWidth: double.infinity,
                      padding: const EdgeInsets.all(15),
                      child: const Text('A Guest',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),),

                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
