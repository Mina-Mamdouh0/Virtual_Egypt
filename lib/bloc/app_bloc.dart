

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/model/package_model.dart';
import 'package:virtual_egypt/model/post_model.dart';
import 'package:virtual_egypt/model/product_model.dart';
import 'package:virtual_egypt/model/signIn_model.dart';
import 'package:virtual_egypt/model/trip_model.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit() : super(InitialState());

  static AppCubit get(context)=>BlocProvider.of(context);



  bool isDarkTheme=false;
  void getDarkTheme()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    isDarkTheme=sharedPreferences.getBool('DarkTheme')??false;
    emit(GetDarkTheme());
  }

  void setDarkTheme(val){
    isDarkTheme=val;
    emit(SetDarkTheme());
  }

  SignUpModel? signUpModel;

  //login
  void userLogin({required String email, required String password,}){
    emit(LoadingLoginScreen());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).
    then((value){
      getDateUser();
      emit(SuccessLoginScreen());
    }).
    onError((error,_){
      emit(ErrorLoginScreen());
    });
  }

  bool obscureText=true;
  void visiblePassword(){
    obscureText=!obscureText;
    emit(VisiblePasswordLogin());
  }
  ///////////////////////////
 //Sign Up

  void userSignUp({required String email, required String password,required String phone,
  required String nationality,required String lung ,required String typeAccount,
  required String lastName,required String firstName}){

    emit(LoadingSignUpScreen());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value){
      //emit(SuccessSignUpScreen());
      createUser(
          phone: phone,
          email: email,
          nationality: nationality,
          lung: lung,
          typeAccount: typeAccount,
          password: password,
          lastName: lastName,
          firstName: firstName,
          uId: value.user!.uid);
    }).onError((error,_){
      emit(ErrorSignUpScreen());
    });
  }

  void createUser({required String email, required String uId, required String firstName,required String lastName, required String phone,
  required String password,required String typeAccount,required String lung,required String nationality}){
    SignUpModel model=SignUpModel(firstName: firstName,lastName: lastName,lung: lung,nationality: nationality,
      email: email, phone: phone, uId: uId,password: password,typeAccount:typeAccount,
        rateApp: 0.0,rateMsgApp: '',rating: 0.0,
        profile: 'https://www.dancehallmag.com/assets/2021/03/burna-boy.jpg',);

    emit(LoadingCreateUserScreen());
    FirebaseFirestore.instance.collection('Users').doc(uId).set(
        model.toMap()
    ).then((value){
      getDateUser();
      emit(SuccessCreateUserScreen());
    }).onError((error,_){
      emit(ErrorCreateUserScreen());
    });
  }

  bool obscureTextPass=true;
  void visiblePasswordSign(){
    obscureTextPass=!obscureTextPass;
    emit(VisiblePasswordLogin());
  }

  bool obscureTextCPass=true;
  void visiblePasswordCSign(){
    obscureTextCPass=!obscureTextCPass;
    emit(VisiblePasswordLogin());
  }

  void getDateUser(){
    signUpModel=null;
   if(FirebaseAuth.instance.currentUser!=null){
     emit(LoadingGetUserScreen());
     FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get().
     then((value){
       signUpModel=SignUpModel.formJson(value.data()!);
       emit(SuccessGetUserScreen());
     }).onError((error,_){
       emit(ErrorGetUserScreen());
     });
   }
  }

  void logout(){
    FirebaseAuth.instance.signOut().whenComplete((){
      emit(LogoutState());
    });
  }
  ////////////////////////////////////////////////////
 //Post

  File? postImage;
  void showImagePost({required File image,}){
    postImage=image;
    emit(ShowImagePost());
  }

  void clearImagePost(){
    postImage=null;
    emit(ClearImagePost());
  }

  void addPost({required String post}){
    String uIdPost=const Uuid().v4();
    PostModel model=PostModel(
      dateTime: Timestamp.now(),
      post: post,
      userId: FirebaseAuth.instance.currentUser!.uid,
      userName: '${signUpModel?.firstName} ${signUpModel?.lastName}',
      userImage: signUpModel!.profile,
      postId:uIdPost,
      likes: [],
    );
    emit(LoadingAddPost());
    FirebaseFirestore.instance.collection('Posts').doc(uIdPost)
        .set(model.toMap())
        .then((value){
      emit(SuccessAddPost());
    }).onError((error,_){
      emit(ErrorAddPost());
    });
  }

  String? url;
  void addPostWithImage({String? post,})async{
    emit(LoadingPostWithImage());
    String uIdPost=const Uuid().v4();
    final ref= FirebaseStorage.instance.ref().child('Posts').
    child(FirebaseAuth.instance.currentUser!.uid).
    child('$post.jpg');
    await ref.putFile(postImage!).then((p0)async {
      url =await ref.getDownloadURL();
      PostModel model=PostModel(
        image: url!,
        dateTime: Timestamp.now(),
        post: post,
        userId: FirebaseAuth.instance.currentUser!.uid,
        userName: '${signUpModel?.firstName} ${signUpModel?.lastName}',
        userImage: signUpModel!.profile,
        postId:uIdPost,
        likes: [],
      );
      FirebaseFirestore.instance.collection('Posts').doc(uIdPost).
      set(model.toMap())
          .then((value){
        emit(SuccessPostWithImage());
      });
    }).onError((error,_){
      emit(ErrorPostWithImage());
    });
  }

  void addTrip({required String dateTrip,required String dropOffGo,
  required String dropOffWant,required String pickUpGo,required String pickUpWant,
  required String total})async{
    emit(LoadingTripState());
    String uIdTrip=const Uuid().v4();
    final ref= FirebaseStorage.instance.ref().child('Trips').
    child(FirebaseAuth.instance.currentUser!.uid).
    child('$uIdTrip.jpg');
    await ref.putFile(file!).then((p0)async {
      url =await ref.getDownloadURL();
      TripModel model=TripModel(
        image: url!,
        dateTime: Timestamp.now(),
        userId: FirebaseAuth.instance.currentUser!.uid,
        userName: '${signUpModel?.firstName} ${signUpModel?.lastName}',
        userImage: signUpModel!.profile,
        rateUser: signUpModel!.rating.toString(),
        tripId: uIdTrip,
        dateTrip:dateTrip ,
        dropOffGo: dropOffGo,
        dropOffWant: dropOffWant,
        pickUpGo: pickUpGo,
        pickUpWant: pickUpWant,
        total: total
      );
      FirebaseFirestore.instance.collection('Trips').doc(uIdTrip).
      set(model.toMap())
          .then((value){
        emit(SuccessTripState());
      });
    }).onError((error,_){
      emit(ErrorTripState());
    });
  }


  void addPackage({required String desc,required String title})async{
    emit(LoadingTripState());
    String uIdTrip=const Uuid().v4();
    final ref= FirebaseStorage.instance.ref().child('Packages').
    child(FirebaseAuth.instance.currentUser!.uid).
    child('$uIdTrip.jpg');
    await ref.putFile(file!).then((p0)async {
      url =await ref.getDownloadURL();
      PackageModel model=PackageModel(
          image: url!,
          id: uIdTrip,
          createAt: Timestamp.now(),
          userId: FirebaseAuth.instance.currentUser!.uid,
          phone: signUpModel?.phone??'',
        desc: desc,
        title: title
      );
      FirebaseFirestore.instance.collection('Packages').doc(uIdTrip).
      set(model.toMap())
          .then((value){
        emit(SuccessTripState());
      });
    }).onError((error,_){
      emit(ErrorTripState());
    });

  }




  String? urlMainImageProduct;
  String? urlImage1Product;
  String? urlImage2Product;
  String? urlImage3Product;

  File? mainImageProduct;
  File? image1Product;
  File? image2Product;
  File? image3Product;

  void showMainImageProduct({required File image,}){
    mainImageProduct=image;
    emit(ShowImagePost());
  }
  void clearMainImageProduct(){
    mainImageProduct=null;
    emit(ClearImagePost());
  }

  void showImage1Product({required File image,}){
    image1Product=image;
    emit(ShowImagePost());
  }
  void clearImage1Product(){
    image1Product=null;
    emit(ClearImagePost());
  }

  void showImage2Product({required File image,}){
    image2Product=image;
    emit(ShowImagePost());
  }

  void clearImage2Product(){
    image2Product=null;
    emit(ClearImagePost());
  }

  void showImage3Product({required File image,}){
    image3Product=image;
    emit(ShowImagePost());
  }
  void clearImage3Product(){
    image3Product=null;
    emit(ClearImagePost());
  }

  void addProduct({required String title,required String rate,
  required String desc,required String price})async{
    emit(LoadingProductState());
    String uIdProduct=const Uuid().v4();
    final ref= FirebaseStorage.instance.ref().child('Products').
    child(FirebaseAuth.instance.currentUser!.uid).
    child('${mainImageProduct!.path}.jpg');
    await ref.putFile(mainImageProduct!).whenComplete((){});
    urlMainImageProduct =await ref.getDownloadURL();

    final ref1= FirebaseStorage.instance.ref().child('Products').
    child(FirebaseAuth.instance.currentUser!.uid).
    child('${image1Product!.path}.jpg');
    await ref1.putFile(image1Product!).whenComplete((){});
    urlImage1Product =await ref1.getDownloadURL();

    final ref2= FirebaseStorage.instance.ref().child('Products').
    child(FirebaseAuth.instance.currentUser!.uid).
    child('${image2Product!.path}.jpg');
    await ref2.putFile(image2Product!).whenComplete((){});
    urlImage2Product =await ref2.getDownloadURL();

    final ref3= FirebaseStorage.instance.ref().child('Products').
    child(FirebaseAuth.instance.currentUser!.uid).
    child('${image3Product!.path}.jpg');
    await ref3.putFile(image3Product!).whenComplete((){});
    urlImage3Product =await ref3.getDownloadURL();

    ProductModel  model=ProductModel(
        image: urlMainImageProduct!,
        dateTime: Timestamp.now(),
        userId: FirebaseAuth.instance.currentUser!.uid,
        userName: '${signUpModel?.firstName} ${signUpModel?.lastName}',
        userImage: signUpModel!.profile,
        title: title,
      image1: urlImage1Product!,
      image2: urlImage2Product!,
      image3: urlImage3Product!,
      productId: uIdProduct,
      userPhone: signUpModel!.phone,
      rate: rate,
      price: price,
      desc: desc,
      likes: []
    );
    FirebaseFirestore.instance.collection('Products').doc(uIdProduct).
    set(model.toMap())
        .then((value){
      emit(SuccessProductState());
    }).onError((error, stackTrace) {
      emit(ErrorProductState());
    });
  }


  ///////////////////////////////
 //setting
  File? file;
  void changeImage(String imagePath){
    file=File(imagePath);
    if(file!=null){
      emit(ChangeImageState());
    }
  }

  void editInfo({required String firstName,required String lastName,required String lung,required String nationality})async{
    if(FirebaseAuth.instance.currentUser!=null){
      emit(LoadingEditInfo());
      final ref = FirebaseStorage.instance.ref().child('UsersImages').
      child(FirebaseAuth.instance.currentUser!.uid).
      child('${file!.path.split('/').last}.jpg');
      await ref.putFile(file!).then((p0) async {
        url = await ref.getDownloadURL();
      });
    }
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'FirstName':firstName,
      'LastName':lastName,
      'Lung':lung,
      'Profile':url,
      'Nationality':nationality,
    }).then((value) {
      emit(SuccessEditInfo());
    }).onError((error, stackTrace){
      emit(ErrorEditInfo());
    });
  }

  void ratingApp({required double rate ,required String ratMsg}){
    emit(LoadingRatApp());
    if(FirebaseAuth.instance.currentUser!=null){
      FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'RateApp':rate,
        'RateMsgApp':ratMsg,
      }).then((value) {
        emit(SuccessRatApp());
      }).onError((error, stackTrace){
        emit(ErrorRatApp());
      });
    }
  }

  String? urlImage1Ads;
  String? urlImage2Ads;
  String? urlImage3Ads;

  File? image1Ads;
  File? image2Ads;
  File? image3Ads;


  void showImage1Ads({required File image,}){
    image1Ads=image;
    emit(ShowImagePost());
  }
  void clearImage1Ads(){
    image1Ads=null;
    emit(ClearImagePost());
  }

  void showImage2Ads({required File image,}){
    image2Ads=image;
    emit(ShowImagePost());
  }

  void clearImage2Ads(){
    image2Ads=null;
    emit(ClearImagePost());
  }

  void showImage3Ads({required File image,}){
    image3Ads=image;
    emit(ShowImagePost());
  }
  void clearImage3Ads(){
    image3Ads=null;
    emit(ClearImagePost());
  }

  void addAdsApp({required String adsText})async{

    emit(LoadingAdsState());

    final ref= FirebaseStorage.instance.ref().child('Ads').
    child(FirebaseAuth.instance.currentUser!.uid).
    child('${image1Ads!.path}.jpg');
    await ref.putFile(image1Ads!).whenComplete((){});
    urlImage1Ads =await ref.getDownloadURL();

    final ref1= FirebaseStorage.instance.ref().child('Ads').
    child(FirebaseAuth.instance.currentUser!.uid).
    child('${image2Ads!.path}.jpg');
    await ref1.putFile(image2Ads!).whenComplete((){});
    urlImage2Ads =await ref1.getDownloadURL();

    final ref2= FirebaseStorage.instance.ref().child('Ads').
    child(FirebaseAuth.instance.currentUser!.uid).
    child('${image3Ads!.path}.jpg');
    await ref2.putFile(image3Ads!).whenComplete((){});
    urlImage3Ads =await ref2.getDownloadURL();

    FirebaseFirestore.instance.collection('Ads').doc('fjJycyaZ2dTGycOWJEWF').update({
      'Text':adsText,
      'Image1':urlImage1Ads,
      'Image2':urlImage2Ads,
      'Image3':urlImage3Ads,
    }).then((value){
      emit(SuccessAdsState());
    }).onError((error, stackTrace){
      emit(ErrorAdsState());
    });
  }



}