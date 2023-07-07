

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/shared/widget.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);

  var postController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return Scaffold(
            backgroundColor: BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
            appBar: AppBar(
              backgroundColor: BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
              foregroundColor: Colors.grey.shade900,
              title: const Text('Create Post',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  )),
              leading:
              InkWell(
                onTap: ()=>Navigator.of(context).pop(),
                child: const Icon(Icons.arrow_back_ios,),
              ),
              elevation: 0.0,
              actions: [
                (state is LoadingAddPost || state is LoadingPostWithImage)?
                  Container():
                    TextButton(onPressed: (){
                      if(cubit.postImage==null){
                        if(postController.text.isNotEmpty){
                          cubit.addPost(post: postController.text);
                        }else{
                          errorToast(msg: 'The post is empty',);
                        }
                      }else{
                        cubit.addPostWithImage(post: postController.text);
                      }
                    }, child: const Text('Post',style: TextStyle(color: Colors.white,),))
            ],
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0XFF000000).withOpacity(0.87),
                      const Color(0XFFFFA437).withOpacity(0.87),
                    ]
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (state is LoadingAddPost || state is LoadingPostWithImage)?
                    const LinearProgressIndicator():Container(),
                    (state is LoadingAddPost || state is LoadingPostWithImage)?
                    const SizedBox(height: 10,):Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(cubit.signUpModel?.profile??''),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Text(cubit.signUpModel?.firstName??'',
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Expanded(
                        child: TextFormField(
                            controller: postController,
                            maxLines: 10,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                hintText: 'what is to mind...',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: InputBorder.none
                            )
                        )
                    ),
                    (cubit.postImage!=null)?
                    Stack(
                      children: [
                        Container(
                          height: 175,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: FileImage(cubit.postImage!)
                              )
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: (){
                              cubit.clearImagePost();
                            },
                            icon: Container(
                              height: 50,
                              width: 50,
                              decoration:const  BoxDecoration(
                                  color: Colors.black38,
                                  shape: BoxShape.circle
                              ),
                              child: const Center(
                                child: Icon(IconlyLight.close_square,
                                    size: 25,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        :Container(),
                    InkWell(
                      onTap: (){
                        showDialogImages(
                            context: context,
                            camera: ()async{
                              Navigator.pop(context);
                              XFile? picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                              if(picked !=null){
                                cubit.showImagePost(image: File(picked.path));
                              }
                            },
                            gallery:()async{
                              Navigator.pop(context);
                              XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                              if(picked !=null){
                                cubit.showImagePost(image: File(picked.path));
                              }
                            }
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(IconlyLight.camera,color: Colors.white,),
                          SizedBox(width: 8,),
                          Text('Add Photo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),)
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,)

                  ],
                ),
              ),
            ),
          );
        },
        listener: (context,state){
          if(state is SuccessAddPost){
            postController.clear();
            BlocProvider.of<AppCubit>(context).postImage=null;
            //SocialCubit.get(context).getPosts();
            Navigator.pop(context);
          }else if(state is SuccessPostWithImage){
            postController.clear();
            BlocProvider.of<AppCubit>(context).postImage=null;
            //SocialCubit.get(context).getPosts();
            Navigator.pop(context);
          }

        });
  }
}