import 'package:flutter/material.dart';

import '../../../constant/theme.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var cardlist = [
    {
      'title': 'Change Password',
      'icon': Icons.lock,
    },
    {
      'title': 'Change Email',
      'icon': Icons.email_outlined,
    },
    {
      'title': 'Change Phone',
      'icon': Icons.phone_outlined,
    },
    {
      'title': 'Change Address',
      'icon': Icons.location_on_outlined,
    },
    {
      'title': 'Change Profile',
      'icon': Icons.person_outline_outlined,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Expanded(
              child: ListView.separated(
                  itemBuilder: ((context, index) {
                    return cardMethod(
                        cardlist[index]['title'], cardlist[index]['icon']);
                  }),
                  separatorBuilder: ((context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  }),
                  itemCount: cardlist.length)),
        ],
      ),
    );
  }

  Card cardMethod(title, icon) {
    return Card(
      color: secondaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListTile(
          title: Text(title, style: headingStyle),
          trailing: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
