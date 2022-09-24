import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

Database? data;

List<Map> contacts=[];

var name = TextEditingController();
var phone = TextEditingController();
var email = TextEditingController();

var name2 = TextEditingController();
var phone2 = TextEditingController();
var email2 = TextEditingController();

var formkey = GlobalKey<FormState>();

