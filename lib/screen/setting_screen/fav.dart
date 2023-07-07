
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/model/product_model.dart';
import 'package:virtual_egypt/screen/main_screen/store_screen.dart';
import 'package:virtual_egypt/shared/widget.dart';

class FavScreen extends StatelessWidget {
   FavScreen({Key? key}) : super(key: key);

  CollectionReference products = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('ProLikes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
        foregroundColor: Colors.grey.shade900,
        centerTitle: true,
        title:  const Text(
          "Fav Product",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white,),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,color: Colors.white),
        ),
      ),
      body: BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
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
                                      (BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Client')?
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
          );
        },
      )

    );
  }
}
