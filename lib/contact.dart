import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class Contact extends StatefulWidget {
  Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _commentController = TextEditingController();

  Future _sendFeedbackToFirebase(BuildContext context) async {
    if (_nameController.text.isEmpty) {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('නම'),
          content: const Text('කරුණාකර නම ඇතුලත් කරන්න'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
                return;
              },
              child: const Text('හරි'),
            )
          ],
        ),
      );
    }

    if (_commentController.text.isEmpty) {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('අදහස්'),
          content: const Text('කරුණාකර අදහස් ඇතුලත් කරන්න'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
                return;
              },
              child: const Text('හරි'),
            )
          ],
        ),
      );
    }

    await FirebaseFirestore.instance.collection('feedbacks').add({
      'name': '${_nameController.text}',
      'comment': '${_commentController.text}'
    });

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('අදහස්'),
        content: const Text('අදහස යවන ලදී'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
              return;
            },
            child: const Text('හරි'),
          )
        ],
      ),
    );

    _nameController.clear();
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      iconTheme: IconThemeData(color: Color(0xff5b5858)),
      flexibleSpace: const Image(
        image: AssetImage('res/0.png'),
        fit: BoxFit.cover,
      ),
      elevation: .5,
      title: Text(
        'අපට කියන්න',
        style: TextStyle(color: Color(0xff5b5858), fontWeight: FontWeight.bold),
      ),
    );
    return Scaffold(
      drawer: MyDrawer(),
      appBar: appBar,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('res/0.png'), fit: BoxFit.cover)),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                controller: _nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide:
                        const BorderSide(color: Color(0xff5b5858), width: 5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide:
                        const BorderSide(color: Color(0xff5b5858), width: 3.0),
                  ),
                  labelText: 'නම',
                  labelStyle: const TextStyle(color: Color(0xff5b5858)),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _commentController,
                maxLines: 10,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide:
                        const BorderSide(color: Color(0xff5b5858), width: 5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide:
                        const BorderSide(color: Color(0xff5b5858), width: 3.0),
                  ),
                  labelText: 'ඔබේ අදහස්',
                  labelStyle: const TextStyle(color: Color(0xff5b5858)),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff5b5858)),
                ),
                onPressed: () async => await _sendFeedbackToFirebase(context),
                child: const Text(
                  'යවන්න',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
