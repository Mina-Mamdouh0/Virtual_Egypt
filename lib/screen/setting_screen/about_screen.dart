

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(builder: (context,state){
      return Scaffold(
          appBar: AppBar(
            backgroundColor:BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
            foregroundColor: Colors.grey.shade900,
            centerTitle: true,
            title:  Text(
              "About",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white,),
            ),
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back,color: Colors.white),
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
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
              child: Text('''
Welcome to the "About Us" page for our tourism application in Egypt!

Our application is designed to provide a convenient and reliable platform for tourists visiting Egypt to discover and book hotels, tours, and leisure activities in different areas of the country.

Here are some common questions and answers about our application:

    What is the application?
    Our application is a tourism application designed specifically for Egypt. It provides users with a range of services to help them explore and book hotels, tours, and leisure activities in different areas of the country.

    What features does the application offer?
    Our application offers many great features, including searching for hotels, booking tours and activities, exploring and discovering different tourist attractions in different areas, modifying and canceling bookings, and communicating with our customer support team for assistance and technical support.

    Does the application require pre-payment?
    Yes, the application requires pre-payment for bookings. You can pay by credit card or available electronic payment services.

    Does the application provide protection for personal information?
    Yes, the application provides protection for users' personal information. Security protocols and encryption are used to protect personal and financial information.

    Can I use the application anywhere in Egypt?
    Yes, you can use the application anywhere in Egypt as long as you have an internet connection.

Thank you for choosing our tourism application for your travels in Egypt!          
          ''',style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),textAlign: TextAlign.justify,
              ),
            ),

          ));
    });
  }
}



class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(builder: (context,state){
      return Scaffold(
          appBar: AppBar(
            backgroundColor:BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
            foregroundColor: Colors.grey.shade900,
            centerTitle: true,
            title:  const Text(
              "Help",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white,),
            ),
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back,color: Colors.white),
            ),
          ),
          body: Container(
            width: double.infinity,
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
              child: Text('''
Welcome to the help page 

If you need assistance using the application or have any questions about the services provided by the application, we are here to help.

Here are some common questions and answers:

How can I find hotels in Egypt?
You can find hotels in Egypt by using the search feature in the application. You can search for hotels in different areas of the country, and filter your search results by price range, star rating, and other criteria.

Can I book tours through the application?
Yes, you can book tours through the application. You can search for available tours and book them through the application.

Is there a tourist guide in the application for Egypt?
Yes, there is a tourist guide in the application for Egypt. You can find more information about tourist attractions and activities in different areas of the country by using the tourism guide in the application.

How can I modify my booking?
You can modify your booking through the application. You can access your bookings and modify the details, such as dates and the number of people.

Can I cancel my booking?
Yes, you can cancel your booking through the application. You can access your bookings and cancel the booking you wish to cancel.

If you have any other questions, please do not hesitate to contact our customer support team. We will be happy to answer any inquiries you may have. Thank you for using our tourism application for your travels in Egypt!          
          ''',style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),textAlign: TextAlign.justify,
              ),
            ),

          ));
    });
  }
}
