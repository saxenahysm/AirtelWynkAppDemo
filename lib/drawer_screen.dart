import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _commonIconSize = 24.0;
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountEmail: Text("user@gmail.com"),
          accountName: Text("UserName"),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://i.pcmag.com/imagery/reviews/03aizylUVApdyLAIku1AvRV-39.1605559903.fit_scale.size_760x427.png"),
          ),
        ),
        ListTile(
            title: Text("Email"),
            leading: Icon(
              Icons.email,
              color: Color(0xFFE76D1C),
              size: _commonIconSize,
            ),
            subtitle: Text("shyam@gmail.com"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF9E9A9A),
              size: _commonIconSize,
            ),
            onTap: () {}),
        ListTile(
          title: Text("Call"),
          leading: Icon(
            Icons.call,
            color: Color(0xFFE76D1C),
            size: _commonIconSize,
          ),
          subtitle: Text("7224857869"),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF9E9A9A),
            size: _commonIconSize,
          ),
          onTap: () {},
        ),
      ],
    ));
  }
}
