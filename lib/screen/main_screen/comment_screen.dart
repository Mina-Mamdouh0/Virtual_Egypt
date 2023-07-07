

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/model/comment_model.dart';


class CommentScreen extends StatelessWidget {
  final String idDoc;
  CommentScreen({Key? key, required this.idDoc,}) : super(key: key);
  TextEditingController controller=TextEditingController();
  FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference comment = FirebaseFirestore.instance.
    collection('Posts').doc(idDoc).collection('Comment');
    return BlocBuilder<AppCubit,AppState>(builder: (context,state){
      return StreamBuilder<QuerySnapshot>(
          stream: comment.orderBy('CreateAt',descending: true).snapshots(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              List<CommentModel> commentList=[];
              for(int i=0;i<snapshot.data!.docs.length;i++){
                commentList.add(CommentModel.jsonData(snapshot.data!.docs[i]));
              }
              return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    centerTitle: true,
                    backgroundColor: BlocProvider.of<AppCubit>(context).isDarkTheme?const Color(0XFF324772):const Color(0XFF4D3212),
                    title: const Text('Comments',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(

                            itemCount: commentList.length,
                            itemBuilder: (context,index){
                              return CommentCustom(commentModel: commentList[index],);

                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller:controller ,
                          decoration:  InputDecoration(
                              hintText: 'Write Comment',
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              suffixIcon: InkWell(
                                onTap: (){
                                  comment.add({
                                    'UserImage': BlocProvider.of<AppCubit>(context).signUpModel?.profile,
                                    'UserName':BlocProvider.of<AppCubit>(context).signUpModel?.firstName,
                                    'UserId':auth.currentUser!.uid,
                                    'CreateAt':Timestamp.now(),
                                    'Comment':controller.text,
                                  });
                                  controller.clear();
                                },
                                child: const Icon(Icons.send,
                                  color:  Color(0XFF4D3212),
                                ),
                              ),
                              focusedBorder:   OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color:  Color(0XFF4D3212),
                                      width: 1
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color:  Color(0XFF4D3212),
                                      width: 1
                                  )
                              )),
                          onSubmitted: (date){
                            comment.add({
                              'UserImage': BlocProvider.of<AppCubit>(context).signUpModel?.profile,
                              'UserName':BlocProvider.of<AppCubit>(context).signUpModel?.firstName,
                              'UserId':auth.currentUser!.uid,
                              'CreateAt':Timestamp.now(),
                              'Comment':controller.text,
                            });

                            controller.clear();
                          },
                        ),
                      ),
                    ],
                  )
              );
            }else{
              return const Scaffold(body: Center(child:  Text('Loading...'),));
            }
          });
    });
  }


}

class CommentCustom extends StatelessWidget {
  CommentCustom({
    Key? key,required this.commentModel,
  }) : super(key: key);
  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(commentModel.userImage),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0XFF4D3212),)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(commentModel.userName,style: const TextStyle(color: Color(0XFF4D3212),fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  Text(commentModel.comment,style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}