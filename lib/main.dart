import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/consts/theme_data.dart';
import 'package:store_app/inner_screens/categories_feeds.dart';
import 'package:store_app/inner_screens/product_details.dart';
import 'package:store_app/inner_screens/upload_product_form.dart';
import 'package:store_app/provider/cart_provider.dart';
import 'package:store_app/provider/dark_theme_provider.dart';
import 'package:store_app/provider/fav_provider.dart';
import 'package:store_app/provider/orders_provider.dart';
import 'package:store_app/provider/products.dart';
import 'package:store_app/screens/auth/forget_password.dart';
import 'package:store_app/screens/auth/login.dart';
import 'package:store_app/screens/auth/sign_up.dart';
import 'package:store_app/screens/bottom_bar.dart';
import 'package:store_app/screens/landing_page.dart';
import 'package:store_app/screens/main_screen.dart';
import 'package:store_app/screens/orders/order.dart';
import 'package:store_app/screens/user_state.dart';
import 'package:store_app/screens/wishlist/wishlist.dart';
import 'package:store_app/widgets/feed_products.dart';
import 'package:store_app/widgets/feeds.dialog.dart';
import 'inner_screens/brands_navigation_rail.dart';
import 'screens/cart/cart.dart';
import 'screens/feeds.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme = await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialisation = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialisation,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              )),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(body: Center(child: Text('Error Occured'))),
            );
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) {
                  return themeChangeProvider;
                }),
                ChangeNotifierProvider(
                  create: (_) => Products(),
                ),
                ChangeNotifierProvider(
                  create: (_) => CartProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => FavProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => OrdersProvider(),
                )
              ],
              child: Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  theme: Styles.themeData(themeChangeProvider.darkTheme, context),
                  home: UserState(),
                  //initialRoute: '/',
                  routes: {
                    //   '/': (ctx) => LandingPage(),
                    BrandNavigationRailScreen.routeName: (ctx) => BrandNavigationRailScreen(),
                    CartScreen.routeName: (ctx) => CartScreen(),
                    FeedsScreen.routeName: (ctx) => FeedsScreen(),
                    WishlistScreen.routeName: (ctx) => WishlistScreen(),
                    ProductDetails.routeName: (ctx) => ProductDetails(),
                    CategoryFeedsScreen.routeName: (ctx) => CategoryFeedsScreen(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                    UploadProductForm.routeName: (ctx) => UploadProductForm(),
                    ForgetPassword.routeName: (ctx) => ForgetPassword(),
                    OrderScreen.routeName: (ctx) => OrderScreen(),
                  },
                );
              }));
        });
  }
}
