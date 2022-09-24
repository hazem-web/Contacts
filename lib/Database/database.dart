
import 'package:contacts/Constants/constants.dart';
import 'package:sqflite/sqflite.dart';

void createdatabase()async{
  data = await openDatabase(
    'contact.db',
    version: 1,
    onCreate:(database, version) {
      database.execute('CREATE TABLE contact (id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT)')
      .then((value) {print("database created");}).catchError((onError){print("error when create table");});
    },
    onOpen: (databse){
      getdata(databse).then((value) {
      contacts=value;
      print(contacts);
      });
      print("database opened");
    },

  );
}
Future insert({required String name,required String email,required String phone})async {
  return await data!.transaction((txn) async{
    await txn.rawInsert('insert into contact(name,email,phone) values("$name","$email","$phone")').then((value)
    {print("$value inserted successfully");}).catchError((error)
    {print("error when insert");});
  });
}
Future getdata(Database data)async{
  return  await data.rawQuery('select * from contact');
}
Future updatedata({required String name,required String email,required String phone,required Map model})async{
  return await data!.rawUpdate('UPDATE contact SET name =? , email = ?, phone = ? WHERE name = ?',['$name', '$email', '$phone','${model['name']}']);
}
Future deletedata({required int id})async{
  return await data!.rawDelete('DELETE FROM contact WHERE id = ?', ['$id']);
}