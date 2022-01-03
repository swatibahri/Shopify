import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:store_app/consts/colors.dart';
import 'package:store_app/inner_screens/product_details.dart';
import 'package:store_app/models/cart_attributes.dart';
import 'package:store_app/provider/cart_provider.dart';
import 'package:store_app/provider/dark_theme_provider.dart';
import 'package:store_app/widgets/global_methods.dart';

class CartFull extends StatefulWidget {
  final String productId;

  const CartFull({this.productId});

  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartAttrs = Provider.of<CartAttributes>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    double subTotal = cartAttrs.price * cartAttrs.quantity;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName, arguments: widget.productId),
      child: Container(
        height: 130,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: const Radius.circular(16), topRight: const Radius.circular(16)),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration:
                  BoxDecoration(image: DecorationImage(image: NetworkImage(cartAttrs.imageUrl), fit: BoxFit.contain)),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            cartAttrs.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32),
                            onTap: () {
                              globalMethods.showDialogBox(
                                  context,
                                  'Remove item',
                                  'Product will be removed from the cart!',
                                  () => cartProvider.removeItem(widget.productId));
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Entypo.cross,
                                color: Colors.red,
                                size: 24,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text('Price:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${cartAttrs.price}\$',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text('Sub Total:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '$subTotal\$',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: themeChange.darkTheme ? Colors.brown.shade900 : Theme.of(context).accentColor),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Free Shipping',
                          style: TextStyle(
                              color: themeChange.darkTheme ? Colors.brown.shade900 : Theme.of(context).accentColor),
                        ),
                        Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: cartAttrs.quantity < 2
                                ? null
                                : () {
                                    cartProvider.reduceItemByOne(widget.productId);
                                  },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Entypo.minus,
                                  color: cartAttrs.quantity < 2 ? Colors.grey : Colors.red,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 12,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              ColorsConsts.gradiendFStart,
                              ColorsConsts.gradiendLEnd,
                            ], stops: [
                              0.0,
                              0.7
                            ])),
                            child: Text(
                              cartAttrs.quantity.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {
                              cartProvider.addProductToCart(
                                  widget.productId, cartAttrs.price, cartAttrs.title, cartAttrs.imageUrl);
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Entypo.plus,
                                  color: Colors.red,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
