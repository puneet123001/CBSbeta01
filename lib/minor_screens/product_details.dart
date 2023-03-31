import 'package:cbsbeta01/widgets/yellow_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/product_model.dart';
import 'full_screen_view.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic proList;
  const ProductDetailScreen({Key? key, required this.proList})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late List<dynamic> imagesList = widget.proList['proimages'];
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: widget.proList['maincateg'])
        .where('subcateg', isEqualTo: widget.proList['subcateg'])
        .snapshots();

    return Material(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>FullScreenView(imagesList: imagesList,)));
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Swiper(
                            pagination: const SwiperPagination(
                                builder: SwiperPagination.fraction),
                            itemBuilder: (context, index) {
                              return Image(
                                image: NetworkImage(
                                  imagesList[index],
                                ),
                              );
                            },
                            itemCount: imagesList.length),
                      ),
                      Positioned(
                        left:5,
                          top: 20,
                          child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      )),
                      Positioned(
                          right:5,
                          top: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: IconButton(
                              icon: const Icon(
                                Icons.share,
                                color: Colors.black,
                              ),
                              onPressed: (){

                              },
                            ),
                          ))
                    ],
                  ),
                ),
                Text(
                  widget.proList['proname'],
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'RS - ',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.proList.get('price').toStringAsFixed(2),
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.red,
                          size: 30,
                        )),
                  ],
                ),
                Text(
                  (widget.proList.get('instock').toString()) +
                      (' pieces available in stock'),
                  style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
                const ProDetailsHeader(
                  label: '   Item Description   ',
                ),
                Text(
                  widget.proList.get('prodesc'),
                  textScaleFactor: 1.1,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey.shade600),
                ),
                const ProDetailsHeader(
                  label: '  Similar Items  ',
                ),
                SizedBox(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _productStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            'This category \n\n has no items yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5),
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        child: StaggeredGridView.countBuilder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              return ProductModel(
                                products: snapshot.data!.docs[index],
                              );
                            },
                            staggeredTileBuilder: (context) =>
                                const StaggeredTile.fit(1)),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.store)),
                    SizedBox(
                      height: 20,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_cart)),
                  ],
                ),
                YellowButton(
                    label: 'ADD TO CART', onPressed: () {}, width: 0.55),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProDetailsHeader extends StatelessWidget {
  final String label;
  const ProDetailsHeader({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
          Text(label,
              style: TextStyle(
                  color: Colors.yellow.shade900,
                  fontSize: 24,
                  fontWeight: FontWeight.w600)),
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
