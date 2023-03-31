import 'package:cbsbeta01/widgets/appbar_widgets.dart';
import 'package:flutter/material.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'CustomerOrders',
        ),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
