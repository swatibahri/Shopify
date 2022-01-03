import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:store_app/consts/app_icons.dart';
import 'package:store_app/consts/colors.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/provider/cart_provider.dart';
import 'package:store_app/provider/fav_provider.dart';
import 'package:store_app/provider/products.dart';
import 'package:store_app/screens/cart/cart.dart';
import 'package:store_app/screens/wishlist/wishlist.dart';
import 'package:store_app/widgets/feed_products.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = '/feeds_screen';

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context).settings.arguments as String;
    final productsProvider = Provider.of<Products>(context);
    //productsProvider.fetchProducts();
    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<FavProvider>(context);
    List<Product> productList = productsProvider.products;
    if (popular == 'popular') {
      productList = productsProvider.popularProducts;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text('Feeds'),
        actions: <Widget>[
          Consumer<FavProvider>(
            builder: (_, favs, ch) => Badge(
              badgeColor: ColorsConsts.cartBadgeColor,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(
                favProvider.getFavItems.length.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: IconButton(
                icon: Icon(
                  AppIcons.wishlist,
                  color: ColorsConsts.favColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(WishlistScreen.routeName);
                },
              ),
            ),
          ),
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              badgeColor: ColorsConsts.cartBadgeColor,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(
                cartProvider.getCartItems.length.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: IconButton(
                icon: Icon(
                  AppIcons.cart,
                  color: ColorsConsts.cartColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
      //     body: StaggeredGridView.countBuilder(
      //   padding: EdgeInsets.symmetric(horizontal: 2),
      //   crossAxisCount: 6,
      //   itemCount: 8,
      //   itemBuilder: (BuildContext context, int index) => FeedProducts(),
      //   staggeredTileBuilder: (int index) => new StaggeredTile.count(3, index.isEven ? 4 : 5),
      //   mainAxisSpacing: 8.0,
      //   crossAxisSpacing: 6.0,
      // )

      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 240 / 400,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(productList.length, (index) {
          return ChangeNotifierProvider.value(
            value: productList[index],
            child: FeedProducts(
                // id: productList[index].id,
                // imageUrl: productList[index].imageUrl,
                //  description: productList[index].description,
                // quantity: productList[index].quantity,
                // price: productList[index].price,
                // isFavorite: productList[index].isFavorite,
                ),
          );
        }),
      ),
    );
  }
}
