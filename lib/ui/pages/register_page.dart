import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage>{

  final _formRegisterKey = GlobalKey<FormState>();

  late TextEditingController _nombres;
  late TextEditingController _paterno;
  late TextEditingController _materno;
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _confirmationPassword;
  late TextEditingController _nacimiento;
  late TextEditingController _empresa;

  final baseUrl = 'https://test-usuarios.herokuapp.com/api';

  @override
  void initState() {
    _nombres = TextEditingController(text: '');
    _paterno = TextEditingController(text: '');
    _materno = TextEditingController(text: '');
    _email = TextEditingController(text: '');
    _confirmationPassword = TextEditingController(text: '');
    _nacimiento = TextEditingController(text: '');
    _empresa = TextEditingController(text: '');
    _password = TextEditingController(text: '');

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
            children: [
              Image.asset("assets/EDteam.png", width: 150,height: 150,),
              Text("Crea una cuenta", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),),
            SizedBox(height: 16,),
              Form(
                key: _formRegisterKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nombres,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        label: Text('Nombres *'),
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty || value==''){
                          return 'El campo nombres es obligatorio';
                        }
                        return null;
                      }
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Flexible(child: TextFormField(
                          controller: _paterno,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            label: Text('Ap. paterno *'),
                          ),
                          validator: (value){
                            if(value==null || value.isEmpty || value==''){
                              return 'El campo apellido paterno es obligatorio';
                            }
                            return null;
                          }
                        ),),
                        SizedBox(width: 8,),
                        Flexible(child: TextFormField(
                          controller: _materno,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            label: Text('Ap. materno'),
                          ),
                        ),)
                      ],
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('email *'),
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
                      controller: _password,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Password *'),
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty || value==''){
                          return 'El campo password es obligatorio';
                        }
                        return null;
                      }
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: _confirmationPassword,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Confirmacion password *'),
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty || value==''){
                          return 'El campo password es obligatorio';
                        }
                        if(value != _password.value.text){
                          return 'Password y la confirmacion del password no son iguales';
                        }
                        return null;
                      }
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Flexible(child: TextFormField(
                          controller: _nacimiento,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.date_range),
                            border: OutlineInputBorder(),
                            label: Text('Nacimiento'),
                          ),
                        ),),
                        SizedBox(width: 8,),
                        Flexible(child: TextFormField(
                          controller: _empresa,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Empresa'),
                          ),
                        ),)
                      ],
                    ),
                  ],
              )),
              SizedBox(height: 16),
              ElevatedButton(onPressed: ()async{
                if(_formRegisterKey.currentState!.validate()){
                  final uri = Uri.parse("${baseUrl}/registrar");
                  final response = await http.post(uri,
                    body: {
                      "Nombres": _nombres.value.text,
                      "ApellidoPaterno": _paterno.value.text,
                      "ApellidoMaterno": _materno.value.text,
                      "email": _email.value.text,
                      "password": _password.value.text,
                      "Empresa": _empresa.value.text,
                      "Fecha": _nacimiento.value.text
                    }
                  );
                  if(response.statusCode == 200){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                      "Usuario registrado correctament"
                    )));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                      "Ocurrio un problema en el servidor"
                    )));
                  }
                }
              }, child: Text("Crear cuenta"))
            ],
          )),
      ),
    );
  }

  @override
  void dispose() {
    _nombres.dispose();
    _paterno.dispose();
    _materno.dispose();
    _email.dispose();
    _password.dispose();
    _confirmationPassword.dispose();
    _nacimiento.dispose();
    _empresa.dispose();

    super.dispose();
  }
}
