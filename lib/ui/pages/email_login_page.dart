import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter_2022_proyecto/ui/pages/remember_password.dart';
import 'package:http/http.dart' as http;

class EmailLoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return EmailLoginPageState();
  }
}

class EmailLoginPageState extends State<EmailLoginPage>{

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _controller;
  late TextEditingController _controller2;

  final baseUrl = 'https://test-usuarios.herokuapp.com/api';

  @override
  initState(){
   _controller = TextEditingController(text: '');
   _controller2 = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset("assets/EDteam.png", width: 150,height: 150,),
          SizedBox(height: 50,),
          Text("Agrega tus credenciales", style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 16,),
          Form(
            key: _formKey,
            child: Column(children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('email'),
              ),
              validator: (value){
                if(value==null || value.isEmpty || value==''){
                  return 'El campo email es obligatorio';
                }
                return null;
              }
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: _controller2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Password'),
              ),
              validator: (value){
                if(value==null || value.isEmpty || value==''){
                  return 'El campo password es obligatorio';
                }
                return null;
              }
            ),
          ]),),
          SizedBox(height: 16),
          GestureDetector(
                child: Text("Olvide mi contraseña", style: TextStyle(
                  color: Colors.blue[700],
                  decoration: TextDecoration.underline
                ),),
                onTap: (){
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>RememberPassword()));
                },
              ),
          SizedBox(height: 16),
          ElevatedButton(onPressed: ()async{
            if(_formKey.currentState!.validate()){
              final uri = Uri.parse("$baseUrl/login");
              final response = await http.post(
                uri,
                body: {
                  "email": _controller.value.text,
                  "password": _controller2.value.text,
                }
              );
              if(response.statusCode == 200) {
                final json = jsonDecode(response.body)['data'];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                  "Bienvenido ${json['Persona']}"
                )));
              }else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                  "Las credenciales no son correctas"
                )));
              }
            }
          }, child: Text("Iniciar sesion"))
        ]),)
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
