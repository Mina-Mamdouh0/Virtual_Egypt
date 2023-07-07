
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:marquee/marquee.dart';
import 'package:virtual_egypt/bloc/app_bloc.dart';
import 'package:virtual_egypt/bloc/app_state.dart';
import 'package:virtual_egypt/model/package_model.dart';
import 'package:virtual_egypt/model/post_model.dart';
import 'package:virtual_egypt/screen/add_screen/add_package_screen.dart';
import 'package:virtual_egypt/screen/main_screen/comment_screen.dart';
import 'package:virtual_egypt/screen/main_screen/package_screen.dart';
import 'package:virtual_egypt/screen/main_screen/tour_screen.dart';
import 'package:virtual_egypt/shared/constent.dart';
import 'package:virtual_egypt/shared/widget.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);


   CollectionReference posts = FirebaseFirestore.instance.collection('Posts');
   CollectionReference ads = FirebaseFirestore.instance.collection('Ads');
   CollectionReference packages = FirebaseFirestore.instance.collection('Packages');

   List<TypeTourModel> listType=[
     TypeTourModel(image: 'assets/images/1.jpg',title: 'Cultural tourism',desc: 'It is one of the largest and oldest types of tourism in Egypt, as Egypt includes many Pharaonic, Greek, Roman, Coptic and Islamic museums and antiquities. Egypt helped decipher the hieroglyphic writing that left a famous mark in the country in the nineteenth century so that you understand the civilization of ancient Egypt, the basic education of writers whose books talk about the details of the life of the pharaohs and their effects. The main destination for cultural tourists in Egypt is the Nile Valley, especially the cities of Cairo, Luxor, and Aswan, and taking a Nile cruise has been a popular choice among countless tourists.'),
     TypeTourModel(image: 'assets/images/2.jpg',title: 'Beach tourism',desc: 'Among the types of tourism in Egypt is beach tourism. Among other attractions in Egypt are the beautiful clear waters of the Red Sea and Sinai beaches and the bright sunshine in any season of the year. This wonderful destination attracts a large number of tourists from all over the world, and the most famous places for this type of tourism are Hurghada, Marsa Alam, Arish, Nuweiba, Ras Sidr, Ain Sokhna, and Sinai. The Red Sea region is characterized by its clear, crystalline waters, coral reefs of different colors, exotic fish, and mountains that take the form of a long chain parallel to the sea, separated from it by a valley suitable for camping. Sinai offers an incredible variety of landscapes and activities for its visitors to enjoy, such as surfing, horseback riding, and playing various sports.'),
     TypeTourModel(image: 'assets/images/3.jpg',title: 'Medical tourism',desc: 'Egypt has long health and healing traditions dating back thousands of years. Since ancient times, Cleopatra was famous for her exquisite beauty, as the queen bathed regularly, always sprinkled with rose petals. Egypt is also known for its warm natural climate and refreshing breeze, while the growing popularity of wellness treatments among holidaymakers, the availability of qualified professionals and the growing number of luxury hotel resorts has helped make Egypt one of the most popular destinations in the world for visitors looking for recovery and relaxation. '),
     TypeTourModel(image: 'assets/images/4.jpg',title: 'Religious tourism',desc: 'Religious tourism in Egypt is tourism that aims to visit places of religious significance or importance, as there are many historical places that can attract travelers for religious purposes, such as the first mosque built in Africa, which is the Amr Ibn Al-Aas Mosque and the Imam Hussein Mosque, in addition to historical mosques. Others that are famous for their distinctive architecture, such as the Ibn Tulun Mosque, Al-Azhar Mosque, and Sultan Hassan Mosque. And many holy monasteries and churches.'),
     TypeTourModel(image: 'assets/images/5.jpg',title: 'Desert tourism',desc: 'The Egyptian desert safari is the best way to feel the spirit of adventure and learn about the life of the Bedouins. This type of tourism is very interesting for all kinds of travelers who are looking for adventure or want to enjoy the natural beauty of the vast desert.The geographical nature of the Sinai Peninsula, located in northwest Egypt, helped to promote safari tourism and make the city the most famous area for this type of tourism. Travel agencies also often offer various safari trips in the beautiful mountains of South Sinai, including visits to St. Catherine\'s Monastery and Mount Moses. Watching the sunrise from the top of Mount Moses is one of the must-see activities for visitors to Sinai.'), TypeTourModel(image: 'assets/images/6.jpg',title: 'Sports tourism',desc: 'It is one of the most important forms of tourism promotion, which has become a key factor in tourist places. Among the most prominent activities of this activity are the Al Jazeera Equestrian Club, the Golf Club, and the Hunting Club, in addition to the sports centers in the Red Sea, Hurghada, and Sharm El-Sheikh. Golf tourism attracts distinguished tourists to Egypt to practice their favorite sports in very beautiful courses and in wonderful tourist places such as Hurghada, Sharm El-Sheikh and Luxor.'),
   ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AppCubit,AppState>(builder: (context,state){
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                StreamBuilder(
                  stream: ads.snapshots(),
                  builder: (context,snapShot){
                    if(snapShot.connectionState==ConnectionState.waiting){
                      return Container();
                    }else if(snapShot.hasData){
                      List<String> offerImages=[snapShot.data!.docs[0]['Image1'],snapShot.data!.docs[0]['Image2'],snapShot.data!.docs[0]['Image3']];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.white,
                            height: 20,
                            child: Marquee(
                              text: '${snapShot.data!.docs[0]['Text']}   ',
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            height: 200,
                            child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return Image.network(
                                  offerImages[index],
                                  fit: BoxFit.fill,
                                );
                              },
                              autoplay: true,
                              itemCount: offerImages.length,
                              pagination: const SwiperPagination(
                                  alignment: Alignment.bottomCenter,
                                  builder: DotSwiperPaginationBuilder(
                                      color: Colors.white, activeColor: Colors.red)),
                              // control: const SwiperControl(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    }else{
                      return Container();
                    }
                  },
                ),

                const SizedBox(height: 10,),
                const Text('Package',style: TextStyle( color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold)),
                const SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ((BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Maid Provider' || BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Admin') && FirebaseAuth.instance.currentUser!=null)?
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPackageScreen()));
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: const Center(child: Icon(Icons.add,size: 30,)),

                      ),
                    ):Container(),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: StreamBuilder(
                        stream: packages.snapshots(),
                        builder: (context,snapShot){
                          if(snapShot.connectionState==ConnectionState.waiting){
                            return Container();
                          }else if(snapShot.hasData){
                            List<PackageModel> pacList=[];
                            for(int i=0;i<snapShot.data!.docs.length;i++){
                              pacList.add(PackageModel.jsonData(snapShot.data!.docs[i]));
                            }
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...pacList.map((e) => InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PackageScreen(packageModel: e,)));
                                    },
                                    child: Container(
                                        height: 150,
                                        width: 150,
                                        padding: const EdgeInsets.all(5) ,
                                        margin: const EdgeInsets.symmetric(horizontal: 3),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(4),
                                                child: Image.network(e.image,fit: BoxFit.fill),
                                              ),
                                            ),
                                            const SizedBox(height: 10,),
                                            Text(e.title,style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)
                                          ],
                                        )

                                    ),
                                  ))
                                ],
                              ),
                            );
                          }else{
                            return Container();
                          }
                        },
                      ),
                    ),


                  ],
                ),
                const SizedBox(height: 10,),
                const Text('Type Tourism',style: TextStyle( color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold)),
                const SizedBox(height: 10,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      ...listType.map((e) => InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>TourScreen(tourModel: e,)));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.asset(e.image,width: 100,height: 100,fit: BoxFit.fill),
                              ),
                              const SizedBox(height: 10,),
                              Text(e.title,style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ))
                    ],

                  ),
                ),
                const SizedBox(height: 10,),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 150,height: 150,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/11.jpg')
                          )
                        ),
                      ),
                      Container(
                        width: 150,height: 150,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/22.jpg')
                            )
                        ),
                      ),
                      Container(
                        width: 150,height: 150,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/33.jpg')
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),

                StreamBuilder(
                    stream: posts.orderBy('DateTime',descending: true).snapshots(),
                    builder: (context,snapShot){
                      if(snapShot.connectionState==ConnectionState.waiting){
                        return loadingApp();
                      }else if (snapShot.hasError){
                        return loadingApp();
                      }
                      if(snapShot.hasData){
                        List<PostModel> postList=[];
                        for(int i=0;i<snapShot.data!.docs.length;i++){
                          postList.add(PostModel.formJson(snapShot.data!.docs[i]));
                        }
                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return Card(
                                elevation: 10,
                                child:
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(postList[index].userImage),
                                          ),
                                          const SizedBox(width: 10,),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(postList[index].userName,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                    const SizedBox(width: 10,),
                                                    const Icon(Icons.done_all_outlined,color: Colors.blue,)

                                                  ],
                                                ),
                                                Text('${postList[index].dateTime.toDate()}',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.normal
                                                  ),),
                                              ],
                                            ),
                                          ),
                                          (BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount=='Admin')?
                                          IconButton(onPressed: (){
                                            FirebaseFirestore.instance.collection('Posts').doc(postList[index].postId).delete();
                                          },
                                              icon: const Icon(Icons.delete,
                                                color: Colors.red,)):Container()
                                        ],
                                      ),
                                      const SizedBox(height: 20,),
                                      Padding(
                                        padding:  const EdgeInsets.only(bottom: 10.0),
                                        child:  Text(postList[index].post??'',
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),),
                                      ),
                                      const SizedBox(height: 10,),
                                      postList[index].image!=null?
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (_){
                                            return Scaffold(
                                              appBar: AppBar(
                                                backgroundColor: Colors.white,
                                                elevation: 0.0,
                                                foregroundColor: Colors.black,
                                              ),
                                              body: Image.network(
                                                height: double.infinity,
                                                width: double.infinity,
                                                fit: BoxFit.fill,
                                                postList[index].image??'',
                                              ),
                                            );
                                          }));

                                        },
                                        child: Image.network(postList[index].image??'',
                                            width: double.infinity),
                                      ):Container(),
                                      const SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.favorite,color: Colors.red,),
                                              const SizedBox(width: 6,),
                                              Text('${postList[index].likes.length}',
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                ),),
                                            ],
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: (){
                                              if(FirebaseAuth.instance.currentUser!=null){
                                                Navigator.push(context, MaterialPageRoute(builder: (_)=>CommentScreen(idDoc: postList[index].postId)));
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.comment,color: Colors.grey),
                                                SizedBox(width: 6,),
                                                Text('Comment',
                                                  softWrap: true,
                                                  overflow: TextOverflow.visible,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                  ),),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(postList[index].userImage),
                                          ),
                                          const SizedBox(width: 10,),
                                          const Expanded(
                                            child: Text('Write the Comment',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.normal
                                              ),),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              if(FirebaseAuth.instance.currentUser!=null){
                                                if(FirebaseAuth.instance.currentUser!.uid!=postList[index].userId && BlocProvider.of<AppCubit>(context).signUpModel?.typeAccount!='Admin'){
                                                  if(postList[index].likes.any((element) => element==FirebaseAuth.instance.currentUser!.uid)){
                                                    postList[index].likes.removeWhere((element) =>element==FirebaseAuth.instance.currentUser!.uid);
                                                    FirebaseFirestore.instance.collection('Posts').doc(postList[index].postId)
                                                        .update({
                                                      'Likes':postList[index].likes,
                                                    });
                                                  }else{
                                                    postList[index].likes.add(FirebaseAuth.instance.currentUser!.uid);
                                                    FirebaseFirestore.instance.collection('Posts').doc(postList[index].postId)
                                                        .update({
                                                      'Likes':postList[index].likes,
                                                    });
                                                  }
                                                }
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children:  const [
                                                Icon(Icons.favorite,color: Colors.red,),
                                                SizedBox(width: 6,),
                                                Text('Support',
                                                  softWrap: true,
                                                  overflow: TextOverflow.visible,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                  ),),

                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context,index){
                              return const SizedBox(
                                width: double.infinity,
                                height: 3,
                              );
                            },
                            itemCount:postList.length
                        );
                      }else{
                        return loadingApp();
                      }
                    }),

                const SizedBox(height: 10,),

              ],
            ),
          ),
        );
      },)
    );
  }
}

class TypeTourModel{
  final String title;
  final String desc;
  final String image;

  TypeTourModel({required this.title,required this.desc,required this.image});
}
