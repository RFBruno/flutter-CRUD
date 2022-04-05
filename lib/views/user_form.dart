import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFromData(user){
    if(user != null){
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {

    final user = ModalRoute.of(context)!.settings.arguments;
    _loadFromData(user);

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de usuário'),
        actions: [
          IconButton(
            onPressed: (){
              final isValid = _form.currentState!.validate();

              if(isValid){
                _form.currentState!.save();
                Provider.of<Users>(context, listen: false).put(User(
                  id : _formData['id'].toString(),
                  name: _formData['name'].toString(),
                  email: _formData['email'].toString(),
                  avatarUrl: _formData['avatarUrl'].toString(),
                  )
                );
                Navigator.of(context).pop();

              }
            },
            icon: Icon(Icons.save)
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child:  Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if(value == null || value.trim().isEmpty){
                    return 'Nome inválido';
                  }
                },
                onSaved: (value) => _formData['name'] = value.toString(),
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(
                  labelText: 'E-mail'
                ),
                onSaved: (value) => _formData['email'] = value.toString(),
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(
                  labelText: 'URL do avatar'
                ),
                onSaved: (value) => _formData['avatarUrl'] = value.toString(),
              )
            ],
          ),
        ),
        ),
    );
  }
}