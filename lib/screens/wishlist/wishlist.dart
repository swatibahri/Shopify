import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/consts/app_icons.dart';
import 'package:store_app/provider/fav_provider.dart';
import 'package:store_app/widgets/global_methods.dart';
import 'package:store_app/screens/wishlist/wishlist_empty.dart';
import 'package:store_app/screens/wishlist/wishlist_full.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();

    return favProvider.getFavItems.isEmpty
        ? Scaffold(body: WishlistEmpty())
        : Scaffold(
            appBar: AppBar(
              title: Text('Wishlist (${favProvider.getFavItems.length})'),
              actions: [
                IconButton(
                    icon: Icon(AppIcons.trash),
                    onPressed: () {
                      globalMethods.showDialogBox(
                          context, 'Clear Wishlist', 'Wishlist will be empty!', () => favProvider.clearFavs());
                    })
              ],
            ),
            body: ListView.builder(
              itemCount: favProvider.getFavItems.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ChangeNotifierProvider.value(
                    value: favProvider.getFavItems.values.toList()[index],
                    child: WishlistFull(
                      productId: favProvider.getFavItems.keys.toList()[index],
                    ));
              },
            ),
          );
  }
}
