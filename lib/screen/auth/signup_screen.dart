
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/screen/layout_screen.dart';
import 'package:virtual_egypt/shared/constent.dart';
import 'package:virtual_egypt/shared/widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController firstName=TextEditingController();
  final TextEditingController lastName=TextEditingController();
  final TextEditingController email=TextEditingController();
  final TextEditingController phone=TextEditingController();
  final TextEditingController password=TextEditingController();
  final TextEditingController confirmPassword=TextEditingController();
  GlobalKey<FormState> kForm=GlobalKey<FormState>();

  String? lunVal;
  List<String> lun=[
    'Arabic',
    'English',
    'French',
    'Spanish',
    'Turkish',
    'Italian',
    'German',
  ];

  String? typeAccountVal;
  List<String> typeAccount=[
    'Client',
    'Maid Provider',
  ];

  String? nationalityVal;
  List<String> nationality=[
    'Afghanistan',
    'Albania',
    'Algeria',
    'American Samoa (United States)',
    'Andorra',
    'Angola',
    "Anguilla (United Kingdom)",
    "Antigua and Barbuda",
    "Argentina",
    "Armenia",
    "Aruba (Netherlands)",
   "Australia[f]",
    "Austria",
    "Azerbaijan[j]",
    "Bahamas",
    "Bahrain",
    'Bangladesh',
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda (United Kingdom)",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "British Virgin Islands" ,
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Caribbean Netherlands (Netherlands)",
    "Cayman Islands (United Kingdom)",
    "Central African Republic",
    "Chad",
    "Chile Americas",
    "China[a]",
    "Colombia",
    "Comoros",
    "Congo",
    "Cook Islands",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Curaçao (Netherlands)",
   "Cyprus[t]",
    "Czechia",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "DR Congo",
    "East Timor",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Eswatini",
    "Ethiopia",
    "Falkland Islands",
    "Faroe Islands",
    "Fiji",
    "Finland[n]",
    "France[c]",
    "French Guiana (France)",
    "French Polynesia (France)",
    "Gabon",
    "Gambia",
    "Georgia[q]",
    "Germany",
    "Ghana",
    "Gibraltar",
    "United Kingdom",
    "Greece",
    "Greenland",
    "Grenada",
    "Guadeloupe (France)",
    "Guam (United States)",
    "Guatemala",
    "Guernsey (United Kingdom)",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hong Kong (China)[l]",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Isle of Man",
    "Italy",
    "Ivory Coast",
    "Jamaica",
    "Japan",
    "Jersey",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Kosovo[s]",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Martinique",
    "Mauritania",
    "Mauritius",
    "Mayotte",
    "Mexico",
    "Micronesia",
    "Moldova[r]",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Montserrat",
    "Morocco",
    "Mozambique",
    "Myanmar",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands[i]",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Niue",
    "North Korea",
    "North Macedonia",
    "Northern Mariana Islands",
    "Norway[o]",
    "Oman",
    "Pakistan",
    "Palau",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Puerto Rico",
    "Qatar",
    "Réunion (France)",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Barthélemy (France)",
    "Saint Helena",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Martin",
    "Saint Pierre and Miquelon",
    "Saint Vincent Grenadines",
    "Samoa",
    "San Marino",
    "São Tomé Príncipe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Sint Maarten",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "South Korea",
    "South Sudan",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Togo",
    "Tokelau",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Turks and Caicos Islands",
    "Tuvalu",
    "U.S. Virgin Islands",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United States",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Venezuela",
    "Vietnam",
    "Wallis and Futuna",
    "Western Sahara",
    "Yemen",
    "Zambia",
    "Zimbabwe",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(ConstantImage.signUpImage,
          height: double.infinity,width: double.infinity,),
          BlocConsumer<AppCubit,AppState>(
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
                          BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF2D85C4):const Color(0XFFFFA437).withOpacity(0.87),
                        ]
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: kForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            const SizedBox(height: 150,),

                            defaultTextFiled(
                                controller: firstName,
                                inputType: TextInputType.text,
                                labelText: 'Enter the first name',
                                prefixIcon: Icons.person_2,
                                validator: (val){
                                  if(val!.isEmpty){
                                    return 'Please Enter The First Name';
                                  }
                                }
                            ),
                            const SizedBox(height: 20,),


                            defaultTextFiled(
                                controller: lastName,
                                inputType: TextInputType.text,
                                labelText: 'Enter the last name',
                                prefixIcon: Icons.person_2,
                                validator: (val){
                                  if(val!.isEmpty){
                                    return 'Please Enter The Second Name';
                                  }
                                }
                            ),
                            const SizedBox(height: 20,),

                            DropdownButtonFormField(
                              validator: (val){
                                if(val==null){
                                  return 'Please Enter The Lung';
                                }
                              },
                              items:  [
                                ...lun.map((e){
                                  return DropdownMenuItem(
                                    value: e.toString(),
                                    child: Text(e),
                                  );
                                }),
                              ],
                              value: lunVal,
                              onChanged: (String? val){
                                lunVal=val;
                              },
                              decoration: InputDecoration(
                                labelText: 'Lun',
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20
                                ),
                                // hintText: labelText,
                                hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20
                                ),

                                fillColor:Colors.white.withOpacity(0.6),
                                filled: true,
                                contentPadding:const  EdgeInsets.all(15),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    borderSide:  const BorderSide(
                                      color: Color(0XFFFFA437),
                                      width: 1,
                                    )
                                ),
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
                              ),
                            ),

                            const SizedBox(height: 20,),

                            DropdownButtonFormField(
                                validator: (val){
                                  if(val==null){
                                    return 'Please Enter The Nationality';
                                  }
                                },
                              items:  [
                                ...nationality.map((e){
                                  return DropdownMenuItem(
                                    value: e.toString(),
                                    child: Text(e),
                                  );
                                }),
                              ],
                              value: nationalityVal,
                              onChanged: (String? val){
                                nationalityVal=val;
                              },
                              decoration: InputDecoration(
                                labelText: 'Nationality',
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20
                                ),
                                // hintText: labelText,
                                hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20
                                ),

                                fillColor:Colors.white.withOpacity(0.6),
                                filled: true,
                                contentPadding:const  EdgeInsets.all(15),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    borderSide:  const BorderSide(
                                      color: Color(0XFFFFA437),
                                      width: 1,
                                    )
                                ),
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
                              ),
                            ),

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
                                controller: phone,
                                inputType: TextInputType.number,
                                labelText: 'Enter your Phone Number ',
                                prefixIcon: Icons.phone,
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'Please Enter The Phone';
                                }
                              },
                            ),

                            const SizedBox(height: 20,),
                            defaultTextFiled(
                                controller: password,
                                inputType: TextInputType.text,
                                labelText: 'Enter your password  ',
                                prefixIcon: Icons.lock,
                               obscureText: cubit.obscureTextPass,
                               suffixIcon: cubit.obscureTextPass?Icons.visibility:Icons.visibility_off,
                               onTapSuffix: ()=>cubit.visiblePasswordSign(),
                               validator: (val){
                                if(val!.isEmpty){
                                  return 'Please Enter The Password';
                                }
                              },
                            ),
                            const SizedBox(height: 20,),

                            defaultTextFiled(
                                controller: confirmPassword,
                                inputType: TextInputType.text,
                                labelText: 'Enter your confirm password',
                                prefixIcon: Icons.lock,
                                obscureText: cubit.obscureTextCPass,
                                suffixIcon: cubit.obscureTextCPass?Icons.visibility:Icons.visibility_off,
                                onTapSuffix: ()=>cubit.visiblePasswordCSign(),
                                validator: (val){
                                if(val!.isEmpty){
                                  return 'Please Enter The Confirm password';
                                }
                              },
                            ),
                            const SizedBox(height: 20,),

                            DropdownButtonFormField(
                              validator: (val){
                                if(val==null){
                                  return 'Please Enter The Type Account';
                                }
                              },
                              items:  [
                                ...typeAccount.map((e){
                                  return DropdownMenuItem(
                                    value: e.toString(),
                                    child: Text(e),
                                  );
                                }),
                              ],
                              value: typeAccountVal,
                              onChanged: (String? val){
                                typeAccountVal=val;
                              },
                              decoration: InputDecoration(
                                labelText: 'Type Account',
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20
                                ),
                                // hintText: labelText,
                                hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20
                                ),

                                fillColor:Colors.white.withOpacity(0.6),
                                filled: true,
                                contentPadding:const  EdgeInsets.all(15),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    borderSide:  const BorderSide(
                                      color: Color(0XFFFFA437),
                                      width: 1,
                                    )
                                ),
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
                              ),
                            ),
                            const SizedBox(height: 20,),


                            (state is LoadingSignUpScreen)?
                            loadingApp():
                            MaterialButton(
                              onPressed: (){
                                if(kForm.currentState!.validate()){
                                  if(password.text!=confirmPassword.text){
                                    errorToast(msg: 'Password Not Matched');
                                  }else{
                                    cubit.userSignUp(
                                      email: email.text,
                                      firstName: firstName.text,
                                      lastName: lastName.text,
                                      typeAccount: typeAccountVal!,
                                      lung: lunVal!,
                                      nationality: nationalityVal!,
                                      password: password.text,
                                      phone: phone.text,);
                                  }
                                 
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              color: BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
                              padding: const EdgeInsets.all(15),
                              child: const Text('SIGN UP',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              listener: (context,state){
                if(state is SuccessCreateUserScreen){
                  successToast(msg: 'Success Sign');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
                }else if(state is ErrorSignUpScreen){
                  errorToast(msg: 'Not Sign , Try Again');

                }
              }),

        ],
      ),
    );
  }
}
