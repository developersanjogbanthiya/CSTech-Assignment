import 'dart:developer';

import 'package:assignment/screens/kyc_page.dart';
import 'package:assignment/screens/products_screen.dart';
import 'package:assignment/service/http_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Categories',
            icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
        currentIndex: 0,
      ),
      appBar: AppBar(
        actions: [
          Container(
            width: width / 100 * 75,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              cursorColor: Color.fromARGB(255, 136, 135, 135),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 223, 223, 223),
                suffixIcon: Icon(Icons.search),
                hintText: 'Search here',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.notifications),
          ),
        ],
      ),
      body: FutureBuilder(
        future: HttpService().getHomeScreenDataRequest(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('No Data Received'),
            );
          }
          final Map<String, dynamic> homeScreenData = snapshot.data!;

          return ListView(
            children: [
              CarouselSlider(
                items: [0, 1].map((i) {
                  return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Image.network(homeScreenData['data']['banner_one'][i]['banner']));
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 600),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 156, 110, 254),
                      const Color.fromARGB(255, 30, 59, 250),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 144,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Gap(12),
                    Text(
                      'KYC Pending',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Gap(8),
                    Text(
                      'You need to provide the required \n documents for your acccount activation.',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (builder) => KycPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Click Here',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (i) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (builder) => ProductsScreen(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Image.network(
                              homeScreenData['data']['category'][i]['icon'],
                            ),
                            Text(homeScreenData['data']['category'][i]['label'])
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: 264,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [const Color.fromARGB(255, 121, 193, 251), Colors.blue],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight),
                ),
                child: Column(
                  children: [
                    Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'EXCLUSIVE FOR YOU',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          4,
                          (i) {
                            return Container(
                              padding: EdgeInsets.all(12),
                              color: Colors.white,
                              height: 264 / 100 * 70,
                              margin: EdgeInsets.all(12),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.network(
                                        homeScreenData['data']['products'][i]['icon'],
                                        height: 116,
                                      ),
                                      Text(
                                        homeScreenData['data']['products'][i]['label'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    color: Colors.green,
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Text(
                                      '${homeScreenData['data']['products'][i]['offer']} off',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
