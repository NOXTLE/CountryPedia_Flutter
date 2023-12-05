import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

// ignore: must_be_immutable
class mainPage extends StatefulWidget {
  mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  var word = TextEditingController();

  var wor = "Japan";

  Future getInfo() async {
    final res = await http.get(
        Uri.parse("https://restcountries.com/v3.1/name/$wor?fullText=true"));

    print(res.body);
    var value = jsonDecode(res.body);

    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.data_array),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Container(
                    height: 200,
                    child: Column(children: [
                      const Text("Search Your Country"),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: word,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              wor = word.text;
                            });
                          },
                          child: Text("search"))
                    ]),
                  ),
                );
              });
        },
      ),
      body: LiquidPullToRefresh(
        onRefresh: () {
          return getInfo();
        },
        child: FutureBuilder(
            future: getInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Data Could Not Be Fetched"),
                );
              }
              var value = snapshot.data;

              return SingleChildScrollView(
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(121, 105, 105, 105),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                                child: Column(children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("${value[0]['name']['common']}"),
                              SizedBox(
                                height: 1,
                              ),
                              Image.network(
                                  "https://flagsapi.com/${value[0]['cca2']}/flat/64.png"),
                              Text("Capital : ${value[0]['capital']}"),
                              Text("Region : ${value[0]['region']}"),
                              Text("Sub-Region : ${value[0]['subregion']}"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("UN Member : ${value[0]['unMember']}"),
                                  Text(
                                      "Independent : ${value[0]['independent']}"),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Also Known As  :\n 1. ${value[0]['altSpellings'][0]} \n 2. ${value[0]['altSpellings'][1]} \n 3.${value[0]['altSpellings'][2]}"),
                              SizedBox(
                                height: 10,
                              ),
                            ])),
                          ),
                        )
                      ]),
                ),
              );
            }),
      ),
    );
  }
}
