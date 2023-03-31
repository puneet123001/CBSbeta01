import 'package:cbsbeta01/main_screens/cart.dart';
import 'package:cbsbeta01/main_screens/category.dart';
import 'package:cbsbeta01/main_screens/profile.dart';
import 'package:cbsbeta01/main_screens/stores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex=0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    const CartScreen(),
    ProfileScreen(documentId: FirebaseAuth.instance.currentUser!.uid,),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:const TextStyle(fontWeight: FontWeight.w600),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index){
          setState(() {
            _selectedIndex=index;
          });
        },),
    );
  }
}
