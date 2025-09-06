import 'package:flutter/material.dart';
import 'package:sinhala_short_stories/drawer.dart';

class Authors extends StatelessWidget {
  const Authors({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      iconTheme: IconThemeData(color: Color(0xff5b5858)),
      flexibleSpace: const Image(
        image: AssetImage('res/containerBG.png'),
        fit: BoxFit.cover,
      ),
      elevation: .5,
      title: Text(
        'ලේඛක මඩුල්ල',
        style: TextStyle(color: Color(0xff5b5858), fontWeight: FontWeight.bold),
      ),
    );

    return Scaffold(
      appBar: appBar,
      drawer: MyDrawer(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('res/0.png'), fit: BoxFit.cover)),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                child: Stack(
                  children: [
                    Ink.image(
                      image: const AssetImage('res/lahiru.png'),
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    const Positioned(
                      bottom: 16,
                      right: 16,
                      left: 16,
                      child: Text(
                        'ලහිරු සම්පත් කරුණාරත්න',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                    const Positioned(
                      bottom: 3,
                      right: 16,
                      left: 16,
                      child: Text(
                        'lahiru.s.karunarathna@gmail.com',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                child: Stack(
                  children: [
                    Ink.image(
                      image: const AssetImage('res/shammi.png'),
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    const Positioned(
                      bottom: 16,
                      right: 16,
                      left: 16,
                      child: Text(
                        'ශම්මි මධුමාධව ඡයතිලක',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                    const Positioned(
                      bottom: 3,
                      right: 16,
                      left: 16,
                      child: Text(
                        'shammijayathilaka96@gmail.com',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
