import 'package:contacts/Constants/constants.dart';
import 'package:contacts/Database/database.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {



  var formkey = GlobalKey<FormState>();

  @override
  void initState() {
    createdatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:Text("Contacts",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
       showDialog(context: context, builder: (context) => Form(
         key: formkey,
         child: builddialog()
       ),);
      },
          child: Icon(Icons.call),backgroundColor: Colors.blue,heroTag: 'cont',),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return buildcontactitem(contacts[index]);
          },
          separatorBuilder: (context, index) {
            return Container(width: double.infinity,height: 1,);
          },
          itemCount: contacts.length
      )



    );
  }
  Widget builddialog(){
    return AlertDialog(
      title: Text("Add Contact"),
      actions: [
        TextFormField(
          keyboardType: TextInputType.text,
          controller: name,
          validator: (value) {
            if(value!.isEmpty){return "Name must not be empty";}
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.face,color: Colors.grey,),
              label: Text("Name")
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: email,
          validator: (value) {
            if(value!.isEmpty||!value.contains('@')){return "Email must be correct";}
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.alternate_email,color: Colors.grey,),
              label: Text("Email")
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.phone,
          controller: phone,
          validator: (value) {
            if(value!.isEmpty){return "Phone must not be empty";}
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone_android,color: Colors.grey,),
              label: Text("Phone")
          ),
        ),
        SizedBox(height: 20,),
        FloatingActionButton(onPressed: (){
          if(formkey.currentState!.validate()){
            insert(name: name.text,email: email.text,phone: phone.text);
            Navigator.pop(context);
            name.clear();
            email.clear();
            phone.clear();
          }
        },child: Icon(Icons.add),backgroundColor: Colors.blue,heroTag: 'add',)
      ],
    );
  }
  Widget buildcontactitem(Map model) {
    return Dismissible(
      key: ObjectKey(model),
      background: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          height: 50,
          color: Colors.red,
          child: Icon(Icons.delete,size: 50,color: Colors.white,),
          alignment: Alignment.centerLeft,
        ),
      ),
      onDismissed: (direction) {
        deletedata(id:model['id']);
      },
      child: Padding(
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
                      ,backgroundColor: Colors.blue,
                    ),
                  ),
                ),

                Expanded(
                  flex: 4,
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
                      showDialog(context: context, builder: (context) {
                        return  Form(
                          key: formkey,
                          child: AlertDialog(
                            title: Text("Edit Contact"),
                            actions: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: name2,
                                validator: (value) {
                                  if(value!.isEmpty){return "Name must not be empty";}
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.face,color: Colors.grey,),
                                    label: Text("Name")
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: email2,
                                validator: (value) {
                                  if(value!.isEmpty||!value.contains('@')){return "Email must be correct";}
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.alternate_email,color: Colors.grey,),
                                    label: Text("Email")
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: phone2,
                                validator: (value) {
                                  if(value!.isEmpty){return "Phone must not be empty";}
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.phone_android,color: Colors.grey,),
                                    label: Text("Phone")
                                ),
                              ),
                              SizedBox(height: 20,),
                              FloatingActionButton(onPressed: (){
                                if(formkey.currentState!.validate()){
                                  updatedata(name: name2.text, email: email2.text, phone: phone2.text, model: model);
                                  Navigator.pop(context);
                                  name.clear();
                                  email.clear();
                                  phone.clear();
                                }
                              },
                                child: Icon(Icons.edit),backgroundColor: Colors.blue,heroTag: 'add',)
                            ],
                          ),
                        );
                      },);
                },icon: Icon(Icons.edit),)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
