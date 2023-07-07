

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/screen/add_screen/add_post_screen.dart';
import 'package:virtual_egypt/screen/add_screen/add_product_screen.dart';
import 'package:virtual_egypt/screen/add_screen/add_trip_screen.dart';
import 'package:virtual_egypt/screen/main_screen/home_screen.dart';
import 'package:virtual_egypt/screen/setting_screen/setting_screen.dart';
import 'package:virtual_egypt/screen/main_screen/store_screen.dart';
import 'package:virtual_egypt/screen/main_screen/trip_screen.dart';
import 'package:virtual_egypt/screen/welcome_screen.dart';
import 'package:virtual_egypt/shared/constent.dart';

class LayoutScreen extends StatelessWidget {
  LayoutScreen({Key? key}) : super(key: key);

  final PersistentTabController _controller=PersistentTabController(initialIndex: 0);
  final List<Widget> buildScreens=[
    HomeScreen(),
    TripScreen(),
    Container(),
    StoreScreen(),
    SettingScreen(),
  ];
  List<PersistentBottomNavBarItem> navBarsItems(BuildContext ctx){
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_filled),
        title: ("Home"),
        activeColorPrimary:BlocProvider.of<AppCubit>(ctx).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.holiday_village),
        title: ("Trip"),
        activeColorPrimary:BlocProvider.of<AppCubit>(ctx).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon:  Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color:BlocProvider.of<AppCubit>(ctx).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Center(child:Icon(Icons.add,color: Colors.white)),
        ),
        activeColorPrimary:BlocProvider.of<AppCubit>(ctx).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
        inactiveColorPrimary: Colors.black,
        onPressed: (context){
          if(FirebaseAuth.instance.currentUser!=null){
            refactorPlusBottomSheet(context: ctx);
          }else{
            Navigator.push(ctx, MaterialPageRoute(builder: (_)=>WelcomeScreen()));
          }

        }
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.store_outlined),
        title: ("Store"),
        activeColorPrimary:BlocProvider.of<AppCubit>(ctx).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Setting"),
        activeColorPrimary:BlocProvider.of<AppCubit>(ctx).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return Navigator.canPop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<AppCubit,AppState>(builder: (context,state){
          return PersistentTabView(
            context,
            controller: _controller,
            screens: buildScreens,
            items: navBarsItems(context),
            onItemSelected: (int val){},
            confineInSafeArea: true,
            backgroundColor: Colors.white,
            handleAndroidBackButtonPress: true,
            popAllScreensOnTapAnyTabs: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0XFF868686).withOpacity(0.25),
                  blurRadius: 10,
                ),
              ],
            ),
            navBarHeight: 60,
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            hideNavigationBar: false,
            itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style11, // Choose the nav bar style with this property.
          );
        },)
      ),
    );
  }

  refactorPlusBottomSheet({required BuildContext context,}){
    return  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (BuildContext cnx ,) {
        return StatefulBuilder(builder: (context, setState1){
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
                height: 325,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5,),
                   // driverSheet(context: context),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 15,),

                           InkWell(
                             onTap: ()=>Navigator.pop(context),
                             child: Image.asset(ConstantImage.triangleImage,
                             color: const Color(0XFFFFA437),
                             width: 100,height: 100),
                           ),
                            const SizedBox(height: 15,),

                            ( BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Client')?
                            MaterialButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPostScreen()));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              color: const Color(0XFFFFA437),
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),

                              child: const Text('Add Post',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),):Container(),

                            const SizedBox(height: 15,),

                            ( BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Maid Provider')?
                            MaterialButton(
                              onPressed: (){
                                BlocProvider.of<AppCubit>(context).file=null;
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTripScreen()));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              color: const Color(0XFFFFA437),
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 65),
                              child: const Text('Add Trip',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),):Container(),

                            const SizedBox(height: 15,),


                            ( BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Maid Provider')?
                            MaterialButton(
                              onPressed: (){
                                BlocProvider.of<AppCubit>(context).file=null;
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProductScreen()));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              color: const Color(0XFFFFA437),
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 65),
                              child: const Text('Add Product',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),):Container(),

                            const SizedBox(height: 15,),

                          ],
                        ),
                      ),
                    ),
                  ],

                )
            ),
          );
        });
      },
    );
  }


}
