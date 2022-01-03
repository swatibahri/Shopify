import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/provider/products.dart';
import 'package:store_app/widgets/feed_products.dart';

class CategoryFeedsScreen extends StatelessWidget {
  static const routeName = '/category_feeds_screen';

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context, listen: false);
    final categoryName = ModalRoute.of(context).settings.arguments as String;
    print(categoryName);
    final productList = productsProvider.findByCategory(categoryName);
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 240 / 400,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(productList.length, (index) {
          return ChangeNotifierProvider.value(
            value: productList[index],
            child: FeedProducts(),
          );
        }),
      ),
    );
  }
}
