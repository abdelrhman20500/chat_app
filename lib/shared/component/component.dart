import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';
import '../constant/constant.dart';

Widget defaultFormField({
  required String hintText,
  required Color color,
  bool? obscureText= false,
  Function(String)? onchange,
}) =>TextFormField(
  obscureText: obscureText as bool,
  validator: (data)
  {
    if(data!.isEmpty){
      return "Field is required";
    }
  },
  onChanged: onchange,
  decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color:color,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
            color: color
        ),
      )
  ),
);

Widget defaultBottom({
  width = double.infinity,
  required String  text,
  VoidCallback? onTap,
})=> InkWell(
  onTap: onTap,
  child:Container(
    width: width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white),
    height: 40,
    child: Text(text,textAlign:TextAlign.center ,
      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30.0,
        color: Color(0xff2B475E)
     ),
    ),
  ),
);

class chatBubble extends StatelessWidget {
   const chatBubble({Key? key,required this.message}) : super(key: key);

   final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child:   Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.only(left: 16, right: 32, bottom: 32, top: 32),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              topRight:Radius.circular(32),
              topLeft:Radius.circular(32),
              bottomRight:Radius.circular(32),
            )
        ),
        child: Text(message.message,
          style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 25, color: Colors.white),),
      ),
    );
  }
}

class chatBubbleForFriend extends StatelessWidget {
  const chatBubbleForFriend({Key? key,required this.message}) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child:   Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.only(left: 16, right: 32, bottom: 32, top: 32),
        decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.only(
              topRight:Radius.circular(32),
              topLeft:Radius.circular(32),
              bottomLeft:Radius.circular(32),
            )
        ),
        child: Text(message.message,
          style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 25, color: Colors.white),),
      ),
    );
  }
}

