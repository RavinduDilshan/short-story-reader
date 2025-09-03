import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact.dart';

class MyDrawer extends StatelessWidget {
  _launchURL() async {
    final uri = Uri.parse('http://mawathegeethaya.blogspot.com/');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('res/0.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: SizedBox.shrink(),
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('res/drawer_img.png'), fit: BoxFit.cover)),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Color(0xff5b5858),
              ),
              title: const Text(
                'ප්‍රධාන පිටුව',
                style:
                    TextStyle(fontSize: 17, color: Color(0xff5b5858), fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer

                context.go('/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Color(0xff5b5858)),
              title: const Text(
                'ලේඛක මඩුල්ල',
                style:
                    TextStyle(fontSize: 17, color: Color(0xff5b5858), fontWeight: FontWeight.bold),
              ),
              onTap: () {
                context.go('/authors');
              },
            ),
            ListTile(
              leading: const Icon(Icons.swap_vertical_circle, color: Color(0xff5b5858)),
              title: const Text(
                'වෙබ් පිටුව',
                style:
                    TextStyle(fontSize: 17, color: Color(0xff5b5858), fontWeight: FontWeight.bold),
              ),
              onTap: _launchURL,
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Color(0xff5b5858)),
              title: const Text(
                'යාලුවන්ට කියන්න',
                style:
                    TextStyle(fontSize: 17, color: Color(0xff5b5858), fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.message, color: Color(0xff5b5858)),
              title: const Text(
                'අපට කියන්න',
                style:
                    TextStyle(fontSize: 17, color: Color(0xff5b5858), fontWeight: FontWeight.bold),
              ),
              onTap: () {
                context.go('/contact');
              },
            ),
          ],
        ),
      ),
    );
  }
}
