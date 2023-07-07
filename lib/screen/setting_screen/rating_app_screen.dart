
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double rate=0;
  final TextEditingController msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppState>(
      builder: (context, state) {
        var cubit=AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor:BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
            foregroundColor: Colors.grey.shade900,
            centerTitle: true,
            title: const Text(
              "Rating App",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cubit.signUpModel!.rateMsgApp.isNotEmpty?const SizedBox(height: 10,):Container(),
                  cubit.signUpModel!.rateMsgApp.isNotEmpty?
                  Column(
                    children: [

                      const Text('Before Rate',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.orange),),
                      const SizedBox(height: 10,),
                      Text(cubit.signUpModel!.rateMsgApp,
                        style:  const TextStyle(fontWeight: FontWeight.normal,fontSize: 20,color: Colors.black),),
                      RatingBar.builder(
                        initialRating: cubit.signUpModel!.rateApp,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ):Container(),
                  const Divider(),


                  const SizedBox(height: 20,),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        rate=rating;
                      });
                      print(rate.toString());
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: msgController,
                    keyboardType: TextInputType.text,
                    maxLength: 150,
                    maxLines: 6,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'must not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: ("Msg Rate"),
                      labelStyle: const TextStyle(
                          color: Colors.orange
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.orange)
                      ),
                      prefixIcon: const Icon(Icons.description,
                          color: Colors.orange),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red)
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  (state is LoadingRatApp)?
                  const Center(child: CircularProgressIndicator(color: Colors.orange),)
                      :MaterialButton(
                    onPressed: () {
                      if (msgController.text.isNotEmpty&&rate!=0.0) {
                        cubit.ratingApp(rate: rate, ratMsg: msgController.text);
                      }else{
                        Fluttertoast.showToast(msg: 'check Data');
                      }
                    },
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    color:BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
                    padding: const EdgeInsets.all(15),
                    child: const Text('UpDate Rate App',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),

                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state){
        if (state is SuccessRatApp){
          BlocProvider.of<AppCubit>(context).getDateUser();
          Navigator.pop(context);
          rate=0.0;
          msgController.clear();
        }else if (state is ErrorRatApp){
          Fluttertoast.showToast(msg: 'Error Upload Rating');
        }
      },
    );
  }
}
