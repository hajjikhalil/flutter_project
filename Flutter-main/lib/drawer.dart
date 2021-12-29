import 'package:flutter/material.dart';

import 'CategoryWidget.dart';
import 'MembreWidget.dart';
import 'composantWidget.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [

          ListTile(
            title: Text(
              "Membres",
              style: TextStyle(fontSize: 15),
            ),
            leading: Icon(
              Icons.view_list ,
              color: Colors.blueAccent,
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MembreWidget()));
            },
          ),
          Divider(
            height: 5,
            color: Colors.grey,
          ),
          ListTile(
            title: Text(
              "Categories",
              style: TextStyle(fontSize: 15),
            ),
            leading: Icon(
              Icons.view_list,
              color: Colors.blueAccent,
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CategoryWidget()));
            },
          ),
          Divider(
            height: 5,
            color: Colors.grey,
          ),
          ListTile(
            title: Text(
              "Composants",
              style: TextStyle(fontSize: 15),
            ),
            leading: Icon(
              Icons.view_list,
              color: Colors.blueAccent,
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ComposantWidget()));
            },
          ),
        ],
      ),
    );
  }
}
