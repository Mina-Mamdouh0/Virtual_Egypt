

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextFiled({
  required TextEditingController controller,
  required TextInputType inputType,
  required String labelText,
  IconData? suffixIcon,
  required IconData prefixIcon,
  Function()? onTapSuffix,
  bool? obscureText,
  bool? enabled,
  FormFieldValidator<String?>? validator,
  Function(String)? onFieldSubmitted,
  Function(String)? onChanged,
  Function()? onEditingComplete,
  Color?suffixIconColor,
  int?maxLines,
  TextInputAction? textInputAction,
  FocusNode? focusNode,
  List<TextInputFormatter>? inputFormatters,
}){
  return  TextFormField(
    keyboardType:inputType ,
    textInputAction: textInputAction??TextInputAction.done,
    controller: controller,
    maxLines: maxLines??1,
    obscureText: obscureText??false,
    focusNode: focusNode,
    inputFormatters: inputFormatters,
    style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w400,
        fontSize: 20
    ),
    decoration: InputDecoration(
      labelText: labelText,
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
      prefixIcon: Icon(prefixIcon,color:Colors.black.withOpacity(0.92)),

      suffixIconColor: suffixIconColor,
      suffixIcon: suffixIcon!=null?IconButton(
          onPressed: onTapSuffix,
          icon: Icon(suffixIcon,color: suffixIconColor??Colors.black.withOpacity(0.92),)):null,
      fillColor:Colors.white.withOpacity(0.6),
      filled: true,
      enabled: enabled??true,
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
    validator: validator,
    onFieldSubmitted: onFieldSubmitted,
    onChanged: onChanged,
    onEditingComplete:onEditingComplete ,
  );
}

Widget loadingApp(){
  return const Center(child: CircularProgressIndicator());
}

successToast({required String msg}){
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    fontSize: 12,
    backgroundColor: Colors.greenAccent,
    textColor: Colors.black,
    gravity: ToastGravity.BOTTOM,
  );
}
errorToast({required String msg}){
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    fontSize: 12,
    backgroundColor: const Color(0XFFFF0000),
    textColor: Colors.white,
    gravity: ToastGravity.BOTTOM,
  );
}

showDialogImages({required BuildContext context, required Function() camera, required Function() gallery,}){
  showDialog(context: context,
      builder: (context){
        return AlertDialog(
          title:const  Text(
            'Please choose an option',
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
                onTap: camera,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.photo,color: Colors.blue,),
                      SizedBox(width: 10,),
                      Text('Camera',
                        style: TextStyle(
                            color: Colors.blue,fontSize: 20
                        ),)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: gallery,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.camera,color: Colors.blue,),
                      SizedBox(width: 10,),
                      Text('Gallery',
                        style: TextStyle(
                            color: Colors.blue,fontSize: 20
                        ),)
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      });
}