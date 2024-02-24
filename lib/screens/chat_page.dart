import 'package:chat_app/model/message.dart';
import 'package:chat_app/shared/component/component.dart';
import 'package:chat_app/shared/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  static String routeName = "ChatPage";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email=ModalRoute.of(context)?.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy("createdAt").snapshots(),
      builder: (context, snapshot){
       if(snapshot.hasData){
        List<Message>messageList = [];
        for(int i=0; i<snapshot.data!.docs.length;i++){
          messageList.add(Message.fromJson(snapshot.data!.docs[i]));
        }
         return Scaffold(
           appBar: AppBar(
             backgroundColor: AppColors.primaryColor,
             automaticallyImplyLeading: false,
             title: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Image.asset("assets/images/scholar.png", height: 60),
                 Text("chat", style: TextStyle(
                     fontSize: 30.0, fontWeight: FontWeight.bold),),
               ],
             ),
           ),
           body: Column(
             children: [
               Expanded(
                 child: ListView.builder(
                   // reverse: true,
                     controller: _scrollController,
                   itemCount: messageList.length,
                     itemBuilder: (context, index) =>
                     messageList[index].id == email?
                     chatBubble(message: messageList[index],): chatBubbleForFriend(message: messageList[index])
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(16),
                 child: TextField(
                   controller: controller,
                   onSubmitted: (data) {
                     messages.add({
                       "messages": data,
                       "createdAt" : DateTime.now(),
                       "id" :email,
                     });
                     controller.clear();
                     _scrollController.animateTo(
                       _scrollController.position.maxScrollExtent,
                       duration: Duration(milliseconds: 500),
                       curve: Curves.easeOut,
                     );
                   },
                   decoration: InputDecoration(
                     hintText: "Send Message",
                     suffixIcon: Icon(Icons.send,
                       color: AppColors.primaryColor,),
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(16)),
                     enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(16)),
                   ),
                 ),
               ),
             ],
           ),
         );
       }else {
         Text("Loading...");
       }
       return Center(child: CircularProgressIndicator());
       },
    );
  }
}
