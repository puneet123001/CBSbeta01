import 'package:cbsbeta01/widgets/appbar_widgets.dart';
import 'package:flutter/material.dart';

class SupplierOrders extends StatelessWidget {
  const SupplierOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'SupplierOrders',
        ),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
