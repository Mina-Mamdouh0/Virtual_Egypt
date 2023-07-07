


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/screen/setting_screen/about_screen.dart';
import 'package:virtual_egypt/screen/setting_screen/add_ads_screen.dart';
import 'package:virtual_egypt/screen/setting_screen/edit_profile_screen.dart';
import 'package:virtual_egypt/screen/setting_screen/fav.dart';
import 'package:virtual_egypt/screen/setting_screen/maid_provider_trips.dart';
import 'package:virtual_egypt/screen/setting_screen/rating_app_screen.dart';
import 'package:virtual_egypt/screen/setting_screen/trips_user.dart';
import 'package:virtual_egypt/screen/welcome_screen.dart';

class SettingScreen extends StatefulWidget {
   SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool val=false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return Container(
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text:  TextSpan(
                        text: 'Hi,  ',
                        style: const TextStyle(
                          color: Color(0XFFFFA437),
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: FirebaseAuth.instance.currentUser==null?'Name':'${cubit.signUpModel?.firstName} ${cubit.signUpModel?.lastName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: FirebaseAuth.instance.currentUser==null?'exmaple@gmail.com':cubit.signUpModel?.email??'',
                      textSize: 18,
                      // isTitle: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    (FirebaseAuth.instance.currentUser!=null)?
                    _listTiles(
                      title: 'Edit Profile',
                      icon: Icons.edit,
                      onPressed: () {
                          PersistentNavBarNavigator.pushNewScreen(context,screen: EditProfileScreen(),withNavBar: false);
                      },
                    ):Container(),
                    (BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Client')?_listTiles(
                      title: 'Fav',
                      icon: Icons.favorite,
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(context,screen: FavScreen(),withNavBar: false);

                      },
                    ):Container(),

                    (BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Client')?
                    _listTiles(
                      title: 'interstet',
                      icon: Icons.filter_tilt_shift_rounded,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TripsUserScreen()));
                      },
                    ):Container(),

                    (BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Maid Provider')?
                    _listTiles(
                      title: 'Trips',
                      icon: Icons.filter_tilt_shift_rounded,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MaidTripsScreen()));
                      },
                    ):Container(),

                    (BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Admin')?
                    _listTiles(
                      title: 'Add ads',
                      icon: Icons.add,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAdsScreen()));

                      },
                    ):Container(),

                    _listTiles(
                      title: 'Help',
                      icon: Icons.help_rounded,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpScreen()));
                      },
                    ),
                    _listTiles(
                      title: 'About',
                      icon: Icons.help_center_rounded,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutScreen()));
                      },
                    ),
                    (FirebaseAuth.instance.currentUser!=null)?
                    _listTiles(
                      title: 'Rating App',
                      icon: Icons.star,
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(context,screen: RatingScreen(),withNavBar: false);
                      },
                    ):Container(),

                    SwitchListTile(
                      title: TextWidget(
                        text: cubit.isDarkTheme ? 'Dark mode' : 'Light mode',
                        textSize: 18,
                        // isTitle: true,
                      ),
                      secondary: Icon(cubit.isDarkTheme
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined),
                      onChanged: (bool value){
                       cubit.setDarkTheme(value);
                      },
                      value: cubit.isDarkTheme,
                    ),

                    (FirebaseAuth.instance.currentUser!=null)?
                    _listTiles(
                      title:  'Logout',
                      icon:  Icons.logout,
                      onPressed: ()=>cubit.logout(),
                    ):Container(),
                    // listTileAsRow(),

                  ],
                ),
              ),
            ),
          );
        },
        listener: (context,state){
          if(state is LogoutState){
            PersistentNavBarNavigator.pushNewScreen(context, screen: const WelcomeScreen(),
            withNavBar: false,
             );
           // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ()));

          }

        },
      )
    );
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        textSize: 20,
        // isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle ?? "",
        textSize: 18,
      ),
      leading: Icon(icon,color: Colors.white),
      trailing: const Icon(Icons.arrow_forward_ios,color: Colors.grey),
      onTap: () {
        onPressed();
      },
    );
  }
}

class TextWidget extends StatelessWidget {
  TextWidget({
    Key? key,
    required this.text,
    required this.textSize,
    this.isTitle = false,
    this.maxLines = 10,
  }) : super(key: key);
  final String text;
  final double textSize;
  bool isTitle;
  int maxLines = 10;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: textSize,color: Colors.white,
          fontWeight: isTitle ? FontWeight.bold : FontWeight.normal),
    );
  }
}

