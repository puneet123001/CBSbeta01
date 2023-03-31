import 'package:cbsbeta01/main_screens/category.dart';
import 'package:cbsbeta01/main_screens/dashboard.dart';
import 'package:cbsbeta01/main_screens/stores.dart';
import 'package:cbsbeta01/main_screens/upload_product.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({Key? key}) : super(key: key);

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedIndex=0;
  final List<Widget> _tabs = const[
    HomeScreen(),
    CategoryScreen(),
    StoresScreen(),
    DashboardScreen(),
    UploadProductScreen(),

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
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
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
