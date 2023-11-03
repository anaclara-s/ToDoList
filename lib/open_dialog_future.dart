import 'package:flutter/material.dart';

Future openDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ITEM'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'DIGITE O ITEM',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('ADCIONAR'),
          ),
        ],
      ),
    );
