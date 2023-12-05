import 'package:countryinfo/Screen/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class one extends StatefulWidget {
  one({super.key});

  @override
  State<one> createState() => _oneState();
}

class _oneState extends State<one> {
  ColorScheme cs = ColorScheme.dark();
  var icon = Icon(Icons.dark_mode);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: cs),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("CountryPedia"),
            actions: [
              GestureDetector(
                  child: icon,
                  onTap: () {
                    if (cs == ColorScheme.dark()) {
                      setState(() {
                        cs = ColorScheme.light();
                        icon = Icon(Icons.light_mode);
                      });
                    } else {
                      setState(() {
                        cs = ColorScheme.dark();
                        icon = Icon(Icons.dark_mode);
                      });
                    }
                  }),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          body: mainPage(),
        ));
  }
}
