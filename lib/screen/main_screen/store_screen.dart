
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/model/product_model.dart';
import 'package:virtual_egypt/shared/constent.dart';
import 'package:virtual_egypt/shared/widget.dart';

class StoreScreen extends StatelessWidget {
   StoreScreen({Key? key}) : super(key: key);

  CollectionReference products = FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(builder: (context,state){
      return SafeArea(
        child: Container(
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
              stream: products.orderBy('DateTime',descending: true).snapshots(),
              builder: (context,snapShot){
                if(snapShot.connectionState==ConnectionState.waiting){
                  return loadingApp();
                }else if (snapShot.hasError){
                  return loadingApp();
                }
                if(snapShot.hasData){
                  List<ProductModel> productsList=[];
                  for(int i=0;i<snapShot.data!.docs.length;i++){
                    productsList.add(ProductModel.formJson(snapShot.data!.docs[i]));
                  }
                  return GridView.builder(
                    itemCount:productsList.length,
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 250
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetailsScreen(
                              productModel: productsList[index],
                            )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3.0,
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    (BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Client' || productsList[index].userId!=BlocProvider.of<AppCubit>(context).signUpModel?.uId)?
                                    IconButton(
                                        onPressed: () {
                                          if(FirebaseAuth.instance.currentUser!=null){
                                            if(FirebaseAuth.instance.currentUser!.uid!=productsList[index].userId && BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount!='Admin'){
                                              if(productsList[index].likes.any((element) => element==FirebaseAuth.instance.currentUser!.uid)){
                                                productsList[index].likes.removeWhere((element) =>element==FirebaseAuth.instance.currentUser!.uid);
                                                FirebaseFirestore.instance.collection('Products').doc(productsList[index].productId)
                                                    .update({
                                                  'Likes':productsList[index].likes,
                                                });
                                                FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
                                                    .collection('ProLikes').doc(productsList[index].productId).delete();

                                              }else{
                                                productsList[index].likes.add(FirebaseAuth.instance.currentUser!.uid);
                                                FirebaseFirestore.instance.collection('Products').doc(productsList[index].productId)
                                                    .update({
                                                  'Likes':productsList[index].likes,
                                                });
                                                FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
                                                    .collection('ProLikes').doc(productsList[index].productId).set(productsList[index].toMap());
                                              }
                                            }
                                          }
                                        },
                                        icon: Icon(
                                          productsList[index].likes.any((element) => element==FirebaseAuth.instance.currentUser!.uid)?Icons.favorite:Icons.favorite_border,
                                          color: Colors.red,
                                        )
                                    ): IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance.collection('Products').
                                          doc(productsList[index].productId).delete();
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )
                                    ),

                                  ],
                                ),
                                Image.network(
                                  productsList[index].image,
                                  fit: BoxFit.fill,
                                  height: 150,width: double.infinity,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        productsList[index].price,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          color: const Color(0XFFFFA437),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 3, right: 2),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:  [
                                              Text(productsList[index].rate,style: const TextStyle(fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),),
                                              const Icon(
                                                Icons.star,
                                                size: 13,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                    },
                  );
                }else{
                  return loadingApp();
                }
              }),
        ),
      );
    });
  }
}



class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;
   const ProductDetailsScreen({ Key? key, required this.productModel}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    List<String> offerImages=[productModel.image,productModel.image1,productModel.image2,productModel.image3];

    return SafeArea(
      child: BlocBuilder<AppCubit,AppState>(
         builder: (context,state){
           return Scaffold(
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
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Stack(
                       children: [
                         Container(
                           color: Colors.transparent,
                           height: 200,
                           child: Swiper(
                             itemBuilder: (BuildContext context, int index) {
                               return Image.network(
                                 offerImages[index],
                                 fit: BoxFit.cover,
                               );
                             },
                             autoplay: true,
                             itemCount: offerImages.length,
                             pagination: const SwiperPagination(
                                 alignment: Alignment.bottomCenter,
                                 builder: DotSwiperPaginationBuilder(
                                     color: Colors.white, activeColor: Colors.red)),
                             // control: const SwiperControl(color: Colors.black),
                           ),
                         ),
                         const SizedBox(height: 10,),
                         Container(
                           padding: const EdgeInsets.only(
                             top: 20,
                             left: 25,
                             right: 25,
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               InkWell(
                                 onTap: () {
                                   Navigator.pop(context);
                                 },
                                 child: Container(
                                   padding: const EdgeInsets.all(8),
                                   decoration:  BoxDecoration(
                                     color:  BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
                                     shape: BoxShape.circle,
                                   ),
                                   child: const Padding(
                                     padding:  EdgeInsets.only(left: 10),
                                     child: Icon(
                                       Icons.arrow_back_ios,
                                       color:  Colors.white,
                                       size: 20,
                                     ),
                                   ),
                                 ),
                               ),

                             ],
                           ),
                         ),
                       ],
                     ),

                     const SizedBox(
                       height: 20,
                     ),

                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children:  [
                           Text(
                             productModel.title,
                             overflow: TextOverflow.ellipsis,
                             style: const TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: Colors.white,
                             ),
                           ),
                           const SizedBox(
                             height: 20,
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Text(
                                 productModel.price,
                                 overflow: TextOverflow.ellipsis,
                                 style: const TextStyle(
                                   fontSize: 20,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.white,
                                 ),
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Text(
                                     productModel.rate,
                                     overflow: TextOverflow.ellipsis,
                                     style: const TextStyle(
                                       fontSize: 20,
                                       fontWeight: FontWeight.bold,
                                       color: Colors.white,
                                     ),
                                   ),
                                   const SizedBox(width: 10,),
                                   const Icon(Icons.star,color: Colors.white,)
                                 ],
                               ),
                             ],
                           ),
                           const SizedBox(
                             height: 20,
                           ),
                           Text(
                               productModel.desc,
                               overflow: TextOverflow.ellipsis,
                               style: const TextStyle(
                                 fontSize: 16,
                                 height: 2,
                                 color:  Colors.white,
                               )
                           )
                         ],
                       ),
                     ),
                     const SizedBox(
                       height: 20,
                     ),
                     Container(
                       height: 190,
                       padding: const EdgeInsets.all(20),
                       margin: const EdgeInsets.all(20),
                       decoration: BoxDecoration(
                           color:  const Color(0XFFE3E3E3),
                           borderRadius: BorderRadius.circular(8),
                           border: Border.all(color: const Color(0XFFE3E3E3))
                       ),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children:[
                               const Text(
                                   'Price',
                                   overflow: TextOverflow.ellipsis,
                                   style: TextStyle(
                                     fontSize: 16,
                                     height: 2,
                                     color:  Color(0XFF003864),
                                   )
                               ),
                               Text(
                                   productModel.price,
                                   overflow: TextOverflow.ellipsis,
                                   style: const TextStyle(
                                     fontSize: 16,
                                     height: 2,
                                     color:   Color(0XFF003864),
                                   )
                               )
                             ],
                           ),

                           MaterialButton(
                               onPressed: (){},
                               color: const Color(0XFF2A2D2E),
                               minWidth: double.infinity,
                               height: 50,
                               elevation: 0.0,

                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children:[
                                   const Text(
                                       'pay',
                                       overflow: TextOverflow.ellipsis,
                                       style: TextStyle(
                                           fontSize: 14,
                                           fontWeight: FontWeight.w700
                                           ,color: Color(0XFFFFFEFC)
                                       )
                                   ),
                                   const SizedBox(height: 50, child: VerticalDivider(width: 20,color:Color(0XFFFFFEFC),thickness: 2,indent: 10,endIndent: 10)),
                                   Text(
                                       productModel.price,
                                       overflow: TextOverflow.ellipsis,
                                       style: const TextStyle(
                                           fontSize: 13,
                                           fontWeight: FontWeight.w400,color: Color(0XFFFFFEFC)
                                       )
                                   ),
                                 ],
                               )
                           ),
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               SvgPicture.asset(ConstantImage.visaImage),
                               SvgPicture.asset(ConstantImage.masterCardImage),
                               SvgPicture.asset(ConstantImage.applePayImage),
                               SvgPicture.asset(ConstantImage.googlePayImage),
                               SvgPicture.asset(ConstantImage.discPayImage),
                             ],
                           ),
                           const Text(
                               'We offer many reliable electronic payment solutions',
                               overflow: TextOverflow.ellipsis,
                               style: TextStyle(
                                   fontSize: 10,
                                   fontWeight: FontWeight.w300,
                                   color: Colors.black45
                               )
                           ),],
                       ),
                     ),

                     (BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Client' || BlocProvider.of<AppCubit>(context).signUpModel?.uId!=productModel.userId)?Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: MaterialButton(
                         onPressed: ()async{//set the number here
                           await FlutterPhoneDirectCaller.callNumber(productModel.userPhone);
                         },
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(200),
                         ),
                         minWidth: double.infinity,
                         color: BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
                         padding: const EdgeInsets.all(15),
                         child: const Text('Call',
                           style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),
                     ):Container()
                   ],
                 ),
               ),
             ),
           );
         },
      )
    );
  }
}





