import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  //creating stateful widget
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late List data;
  int itemCount = 500;
  List<bool> selected = new List<bool>.filled(500, false, growable: true);

  @override
  Widget build(BuildContext context) {
    @override
    initState() {
      for (var i = 0; i < itemCount; i++) {
        selected.add(false);
      }
      super.initState();
    }

    Icon like = Icon(
      Icons.favorite, // Icons.favorite
      color: Colors.pink, // Colors.red
    );

    Icon unlike = Icon(
      Icons.favorite, // Icons.favorite
      color: Colors.white, // Colors.red
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('ASANAS',
              style: GoogleFonts.lora(
                  fontWeight: FontWeight.bold, fontSize: 20.0)),
          centerTitle: true,
          backgroundColor: Colors.cyan[300],
        ),
        body: Container(
          color: Colors.cyan[300],
          child: Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/data.json'),
                builder: (context, snapshot) {
                  // Decode the JSON
                  var newData = json.decode(snapshot.data.toString());

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      // Build the ListView
                      itemBuilder: (BuildContext context, int index) {
                        String url = newData[index]['image'];
                        return GestureDetector(
                          onTap: () {
                            showDialogFunc(
                                context,
                                newData[index]['image'],
                                newData[index]['name'],
                                newData[index]['description']);
                          },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Stack(
                                    children: [
                                      Image.network(url),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.cyan[300],
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.share,
                                                  size: 22,
                                                ),
                                                color: Colors.white,
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.cyan[300],
                                              child: IconButton(
                                                icon: selected.elementAt(index)
                                                    ? like
                                                    : unlike,
                                                onPressed: () {
                                                  setState(() {
                                                    selected[index] = !selected
                                                        .elementAt(index);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            AssetImage("assets/img.jpg"),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 50, right: 50),
                                        child: Text(
                                          newData[index]['name'],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lora(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22.0,
                                              color: Colors.cyan[500]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(newData[index]['description'],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lora(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Colors.black)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: newData == null ? 0 : newData.length,
                    ),
                  );
                }),
          ),
        ));
  }
}

showDialogFunc(context, img, title, desc) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(2),
            height: 320,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    img,
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(title,
                    style: GoogleFonts.lora(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.cyan)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(desc,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lora(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
