import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

Widget buildcontactitem(Map model) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Container(
      width: double.infinity,
      height: 110,
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: 25,
                  child: Text("${model['name'][0]}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30,),)
                  ,backgroundColor: Colors.green,
                ),
              ),
            ),

            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${model['name']}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
                  Text("Telephone:${model['phone']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                  Text("Email:${model['email']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)

                ],
              ),
            ),

            Expanded(child: IconButton( onPressed: (){

            },icon: Icon(Icons.edit),)
            )
          ],
        ),
      ),
    ),
  );
}