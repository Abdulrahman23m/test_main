import 'package:brandz/model/category_model.dart';
import 'package:brandz/model/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/control_view_model.dart';
import 'auth/widget/custom_text.dart';

final controller = ControlViewModel();

class HomeView extends StatelessWidget {
  @override
  final Homemodel = HomeViewModel();
  final Stream<QuerySnapshot> categories =
      FirebaseFirestore.instance.collection('Categories').snapshots();

  final Stream<QuerySnapshot> brands =
      FirebaseFirestore.instance.collection('Brands').snapshots();

  final List<String> names = <String>[
    'men',
    's',
    's',
    's',
  ];

  Widget _searchTextFormField() {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            )),
      ),
    );
  }

  Future getImage(BuildContext context, String ImageName) async {
    Image image;
    // a
  }

  Widget _listViewCategory() {
    // return Text('data');
    return Container(
      height: 100,
      child: StreamBuilder(
          stream: categories,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("first if");
            }
            if (snapshot.hasError) {
              return Text("There is an error");
            }
            final data = snapshot.requireData;

            print(data.docs[1]['name']);
            return ListView.separated(
              itemCount: data.size,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey.shade100,
                      ),
                      height: 60,
                      width: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          data.docs[index]['image'],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: data.docs[index]['name'],
                    )
                  ],
                );
              },
              separatorBuilder: (context, int index) => SizedBox(
                width: 20,
              ),
            );
          }),
    );
  }

  Widget _listViewProduct() {
    return Container(
      height: 220,
      child: ListView.separated(
        itemCount: names.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * .3,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.shade100,
                  ),
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Container(
                      height: 140,
                      child: Image.asset(
                        'assets/images/blackHoodie.jpg',
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  height: 3,
                ),
                CustomText(
                  text: 'Black Hoodie ',
                  alignment: Alignment.bottomLeft,
                  fontSize: 16,
                ),
                CustomText(
                  text: 'Black Hoodie ',
                  alignment: Alignment.bottomLeft,
                  color: Colors.grey,
                  fontSize: 13,
                ),
                CustomText(
                  text: '\$45 ',
                  alignment: Alignment.bottomLeft,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, int index) => SizedBox(
          width: 20,
        ),
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            activeIcon: Text('Explore'),
            label: '',
            icon: Image.asset(
              'assets/images/Icon_Explore.png',
              fit: BoxFit.contain,
            )),
        BottomNavigationBarItem(
            activeIcon: Text('Cart'),
            label: '',
            icon: Image.asset(
              'assets/images/Icon_Cart.png',
              fit: BoxFit.contain,
            )),
        BottomNavigationBarItem(
            activeIcon: Text('User'),
            label: '',
            icon: Image.asset(
              'assets/images/Icon_User.png',
              fit: BoxFit.contain,
            )),
      ],
      currentIndex: controller.navigatorValue,
      onTap: (index) {
        controller.changeSelectedValue(index);
        if (index == 1) {
          // Get.to(CartView());
        }
      },
      selectedItemColor: Colors.black,
      backgroundColor: Colors.grey.shade100,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: AppBar(
          title: Text('Brandz'),
          // toolbarHeight: 9,
          centerTitle: true,
          titleSpacing: 0,
          backgroundColor: Colors.black,
          // leadingWidth: 3,),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          children: [
            _searchTextFormField(),
            SizedBox(
              height: 20,
            ),
            CustomText(
              text: 'Categories',
            ),
            _listViewCategory(),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 0,
            ),
            CustomText(
              text: "Brands",
            ),
            SizedBox(
              height: 10,
            ),
            //container
            Container(
              height: 100,
              child: ListView.separated(
                itemCount: names.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey.shade100,
                        ),
                        height: 60,
                        width: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/images/brand2.png"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        text: names[index],
                      )
                    ],
                  );
                },
                separatorBuilder: (context, int index) => SizedBox(
                  width: 20,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Best selling',
                  fontSize: 18,
                ),
                CustomText(
                  text: 'See all',
                  fontSize: 16,
                ),
              ],
            ),
            _listViewProduct(),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}
