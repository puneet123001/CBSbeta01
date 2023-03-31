
import 'package:cbsbeta01/categories/bags_catog.dart';
import 'package:cbsbeta01/categories/men_catog.dart';
import 'package:cbsbeta01/categories/shoes_catog.dart';
import 'package:cbsbeta01/categories/women_catog.dart';
import 'package:cbsbeta01/main_screens/category.dart';
import 'package:cbsbeta01/widgets/fake_search.dart';
import 'package:flutter/material.dart';

List<ItemsData> items =[
 ItemsData(label: 'Men'),
ItemsData(label: 'Women'),
ItemsData(label: 'Shoes'),
ItemsData(label: 'Bags'),
ItemsData(label: 'Electronics'),
ItemsData(label: 'Accessories'),
ItemsData(label: 'Home And Kitchen'),
ItemsData(label: 'Kids'),
ItemsData(label: 'Beauty'),
];
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  final PageController _pageController = PageController();
  @override
  void initState() {
    for (var element in items) {
      element.isSelected = false;
    }
    setState(() {
      items[0].isSelected = true;
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:0,
        backgroundColor:Colors.white,
        title: const FakeScreen(),
      ),
    body: Stack(
      children: [
        Positioned(
            bottom:0,
            left:0,
            child: sideNavigator()),
        Positioned(
            bottom:0,
            right:0,
            child:categoryView(),)
      ],
    ),);
  }
  Widget sideNavigator (){
   return SizedBox(height: MediaQuery.of(context).size.height*0.8,width: MediaQuery.of(context).size.width*0.2,
   child: ListView.builder(itemCount:items.length,itemBuilder: (context,index){
     return GestureDetector(
       onTap: (){
         _pageController.animateToPage(index,duration: const Duration(milliseconds: 100),curve:Curves.bounceIn);
       },
       child: Container(
       color:items[index].isSelected==true?Colors.white: Colors.grey.shade300,
         height: 100,child: Center(child: Text(items[index].label),
       ),
       ),
     );
   }),
   );
  }
  Widget categoryView(){
    return Container(height: MediaQuery.of(context).size.height*0.8,width: MediaQuery.of(context).size.width*0.8,color: Colors.white,
    child: PageView(
      controller: _pageController,
      onPageChanged: (value) {
        for (var element in items) {
          element.isSelected = false;
        }
        setState(() {
          items[value].isSelected = true;
        });
      },
      scrollDirection:Axis.vertical,
      children:const [
      MenCategory(),
      WomenCategory(),
      ShoesCategory(),
      BagsCategory(),
      Center(child: Text('electronics category')),
      Center(child: Text('accessories category')),
      Center(child: Text('home and garden category')),
      Center(child: Text('kidscategory')),
      Center(child: Text('beauty category')),



    ],),);
  }
}
class ItemsData{
  String label;
  bool isSelected;
  ItemsData({required this.label,this.isSelected=false});
}
