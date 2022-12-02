import "package:flutter/material.dart";

class RememberPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RememberPasswordState();
  }
}

class RememberPasswordState extends State<RememberPassword>{

  late TextEditingController _email;
  @override
  void initState() {
    _email = TextEditingController(text: '');
    // TODO: implement initState
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset("assets/EDteam.png", width: 150,height: 150,),
          Text("Recuperar credenciales", style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 16,),
          Form(
            child: Form(
              child: TextFormField(
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
              ),)
          ),
          SizedBox(height: 16),
          ElevatedButton(onPressed: (){}, child: Text("Recuperar credenciales")),
          SizedBox(height: 24),
          Text("Recuerda no difundir tus credenciales de forma publica, recuerda cambiar frecuentemente tus credenciales", style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          ),
          textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
  
  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }
}
