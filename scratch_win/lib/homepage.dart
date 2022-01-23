// ignore_for_file: prefer_const_constructors, unused_import, unused_local_variable, dead_code, unnecessary_this

import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // import images
  AssetImage circle = AssetImage('images/circle.png');
  AssetImage lucky = AssetImage('images/rupee.png');
  AssetImage unlucky = AssetImage('images/sadFace.png');

  //get an array
  late List<String> itemArray; //we can make a list of 25 'empty' strings
  late int luckyNumber; // Globle variable is necessary

  //initalize the arrays
  @override
  void initState() {
    super.initState();
    String message = '';
    itemArray = List<String>.generate(25,(index) =>'empty'); // it gernrates list which contains 25 "empty" strings OR shortcut Method
    genrateRandomNumber();
  }

  genrateRandomNumber() {
    late int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  //define a get image method
  getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case 'lucky':
        return lucky;
        break;
      case 'unlucky':
        return unlucky;
        break;
    }
    return circle; // for all other cases
  }

  //play game method
  playgame(int index) {
    if (luckyNumber == index) {
      setState(() {
        itemArray[index] = 'lucky';
      });
    } else {
      setState(() {
        itemArray[index] = 'unlucky';
      });
    }
  }

  //show all
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, 'unlucky');
      itemArray[luckyNumber] = 'lucky';
    });
  }

  //reset all
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25,
          'empty'); // it will fill 25 spot's with 25 , dont use genrate method because it is only used for initialize
    });
    genrateRandomNumber(); // to set the random number agein
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Scratch and win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: itemArray.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.grey,
                  onPressed: () {
                    this.playgame(i);
                  },
                  child: Image(
                    image: this.getImage(i),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(100.0, 40.0, 100.0, 40.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              minWidth: 50,
              height: 10.0,
              onPressed: () {
                this.showAll();
              },
              color: Colors.blueGrey,
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Show All',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(100.0, 30.0, 100.0, 30.0),
            child: MaterialButton(
              onPressed: () {
                this.resetGame();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              minWidth: 50,
              height: 10.0,
              padding: EdgeInsets.all(10),
              color: Colors.blueGrey,
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
