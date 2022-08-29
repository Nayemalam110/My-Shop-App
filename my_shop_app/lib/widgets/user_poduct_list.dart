import 'package:flutter/material.dart';

class UserProductList extends StatelessWidget {
  final String title;
  final String imgUrl;
  const UserProductList(this.title, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        leading: FittedBox(
          child: CircleAvatar(backgroundImage: NetworkImage(imgUrl)),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
        trailing: Container(
          width: 100,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
            ),
          ]),
        ),
      ),
    );
  }
}
