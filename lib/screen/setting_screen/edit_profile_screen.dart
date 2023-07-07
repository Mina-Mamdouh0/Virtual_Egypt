
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/shared/widget.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final TextEditingController firstName=TextEditingController();
  final TextEditingController lastName=TextEditingController();

  final formKey = GlobalKey<FormState>();

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
    return BlocConsumer<AppCubit,AppState>(
        builder: (context, state) {
          var cubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor:BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
              foregroundColor: Colors.grey.shade900,
              centerTitle: true,
              title:  const Text(
                "Edit Info",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white,),
              ),
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                  cubit.file=null;
                },
                icon: const Icon(Icons.arrow_back,color: Colors.white),
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
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            margin:const  EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.width*0.2,
                            width: MediaQuery.of(context).size.width*0.2,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: cubit.file==null?Image.asset('assets/images/eyes.png',
                                fit: BoxFit.fill,):Image.file(cubit.file!,
                                fit: BoxFit.fill,),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              showDialog(context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      title:const  Text(
                                        'Choose Image',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: ()async{
                                              Navigator.pop(context);
                                              XFile? picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                              if(picked !=null){
                                                cubit.changeImage(picked.path);
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: const [
                                                  Icon(Icons.photo,color: Colors.orange,),
                                                  SizedBox(width: 10,),
                                                  Text('Camera',
                                                    style: TextStyle(
                                                        color: Colors.orange,fontSize: 20
                                                    ),)
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: ()async{
                                              Navigator.pop(context);
                                              XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                              if(picked !=null){
                                                cubit.changeImage(picked.path);
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: const [
                                                  Icon(Icons.camera,color: Colors.orange,),
                                                  SizedBox(width: 10,),
                                                  Text('Gallery',
                                                    style: TextStyle(
                                                        color: Colors.orange,fontSize: 20
                                                    ),)
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 2,
                                      color: Colors.white),
                                  color: Colors.pink
                              ),
                              child: Icon(cubit.file==null?Icons.camera_alt:Icons.edit,
                                color: Colors.white,
                                size: 20,),

                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),

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

                      (state is LoadingEditInfo)?
                      loadingApp()
                          :MaterialButton(
                        onPressed: (){
                          if (formKey.currentState!.validate()) {
                            if(cubit.file!=null){
                              cubit.editInfo(
                                  firstName: firstName.text,
                                  lastName: lastName.text,
                                  lung: lunVal!,
                                  nationality: nationalityVal!);
                            }else{
                              successToast(msg: 'check to Chose image');
                            }
                          }else{
                            errorToast(msg: 'check Data');
                          }
                        },
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200),
                        ),
                        color: BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
                        padding: const EdgeInsets.all(15),
                        child: const Text('Edit Info',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),


                    ],
                  ),
                ),
              ),
            ),

          );
        },
        listener: (context, state){
          if(state is SuccessEditInfo){
            BlocProvider.of<AppCubit>(context).getDateUser();
            BlocProvider.of<AppCubit>(context).file=null;
            Navigator.of(context).pop();
          }else if(state is ErrorEditInfo){
            Fluttertoast.showToast(msg: 'Error in Edit');
            BlocProvider.of<AppCubit>(context).file=null;
            Navigator.of(context).pop();
          }
        });
  }
}
