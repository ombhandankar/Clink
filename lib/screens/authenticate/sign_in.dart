import 'package:chumma/services/auth.dart';
import 'package:chumma/shared/loading.dart';
import 'package:flutter/material.dart';

class SignedIn extends StatefulWidget {

  final Function toggleView;
  const SignedIn({Key? key,required this.toggleView}) : super(key: key);

  @override
  State<SignedIn> createState() => _SignedInState();
}

class _SignedInState extends State<SignedIn> {
  @override

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  var email = '';
  var password = '';
  var error = '';

  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[150],
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('Sign In Here'),
        actions: <Widget> [
          TextButton.icon(
          icon: Icon(Icons.person),
          label : Text('Register'),
          onPressed: () {
            widget.toggleView();
          },
      ),
        ],
        ),
      body: Container(
        padding: EdgeInsets.symmetric(),
        child: Form(
          key: _formKey,
          child: Column(
            children:<Widget> [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Clink',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter an email' : null ,
                decoration: InputDecoration(
                  icon: Icon(Icons.email_sharp),
                  labelText: 'Email ID',
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  validator: (val) => val!.length < 6 ? 'Password should be 6 characters' : null ,
                  obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.password_sharp),
                    labelText: 'Password',
                    border: OutlineInputBorder()),
              onChanged: (val) {
                setState(() {
                  password = val;
                });
          }
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                  ),
                  child: Text('Sign in',
                  style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  if(_formKey.currentState!.validate()) //checks if current state of the form is validated
                  {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _authService.signInWithEmail(email, password);
                    if(result==null)
                    {
                      setState(() {
                        error = 'couldnt sign in';
                        loading = false;
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
        ),
    );
  }
}
