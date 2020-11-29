import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2))
            ]),
        width: 300,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: Text(
                    "برترین فیلم های تاریخ سینما",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
                width: 128,
                height: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 10,
                      child: Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/images/1.jpg")))),
                    ),
                    Positioned(
                      top: 10,
                      child: Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/images/2.jpg")))),
                    ),
                    Positioned(
                      right: 60,
                      child: Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/images/3.jpg")))),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
