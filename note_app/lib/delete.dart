import 'package:flutter/material.dart';


class DeleteNote extends StatelessWidget {
 final  String title ;

  const DeleteNote({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body:const  Center(
        child: Text(
          'delete Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}