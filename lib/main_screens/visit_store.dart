import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/product_model.dart';

class VisitStore extends StatefulWidget {
  final String suppId;
  const VisitStore({Key? key, required this.suppId}) : super(key: key);

  @override
  State<VisitStore> createState() => _VisitStoreState();
}

class _VisitStoreState extends State<VisitStore> {
  @override
  Widget build(BuildContext context) {
    CollectionReference suppliers =
        FirebaseFirestore.instance.collection('suppliers');

    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
        .collection('products')
        .where('sid', isEqualTo: widget.suppId)
        .snapshots();

    return FutureBuilder<DocumentSnapshot>(
      future: suppliers.doc(widget.suppId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Colors.blueGrey.shade100,
            appBar: AppBar(
              toolbarHeight: 100,
              flexibleSpace: Image.asset(
                'images/inapp/coverimage.jpg',
                fit: BoxFit.cover,
              ),
            ),

          body:
          StreamBuilder<QuerySnapshot>(
            stream: _productStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Material(
                  child:  Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    'This store \n\n has no items yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey, fontSize: 26,fontWeight: FontWeight.bold,letterSpacing: 1.5),
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
                      return ProductModel(products: snapshot.data!.docs[index],);
                    },
                    staggeredTileBuilder: (context) => const StaggeredTile.fit(1)),
              );

            },
          ),);
        }

        return const Text("loading");
      },
    );
  }
}
