import 'package:backdrop/backdrop.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:store_app/consts/colors.dart';
import 'package:store_app/inner_screens/brands_navigation_rail.dart';
import 'package:store_app/provider/products.dart';
import 'package:store_app/screens/feeds.dart';
import 'package:store_app/widgets/backlayer.dart';
import 'package:store_app/widgets/category.dart';
import 'package:store_app/widgets/popular_products.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _carouselImages = [
    ExactAssetImage('assets/images/carousel1.png'),
    ExactAssetImage('assets/images/carousel2.jpeg'),
    ExactAssetImage('assets/images/carousel3.jpg'),
    ExactAssetImage("assets/images/carousel4.png")
  ];

  List _brandImages = [
    'assets/images/addidas.jpg',
    'assets/images/apple.jpg',
    'assets/images/dell.jpg',
    'assets/images/h&m.jpg',
    'assets/images/nike.jpg',
    'assets/images/samsung.jpg',
    'assets/images/huawei.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final popularItems = productsData.popularProducts;
    return Scaffold(
      body: BackdropScaffold(
        frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        headerHeight: MediaQuery.of(context).size.height * 0.25,
        appBar: BackdropAppBar(
          title: Text("Home"),
          leading: BackdropToggleButton(
            icon: AnimatedIcons.home_menu,
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorsConsts.starterColor, ColorsConsts.endColor],
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
                iconSize: 15,
                padding: const EdgeInsets.all(10),
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundImage: NetworkImage(
                      'https://rukminim1.flixcart.com/image/580/696/kljrvrk0/shoe/e/q/m/4-mw-1102-women-white-4-mileswalker-white-original-imagyn5egchvbmrh.jpeg?q=50',
                    ),
                  ),
                ),
                onPressed: () {})
          ],
        ),
        //stickyFrontLayer: true,
        frontLayer: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 190.0,
                width: double.infinity,
                child: Carousel(
                  images: [_carouselImages[0], _carouselImages[1], _carouselImages[2], _carouselImages[3]],
                  autoplay: true,
                  boxFit: BoxFit.fill,
                  animationDuration: Duration(microseconds: 1000),
                  dotSize: 5.0,
                  animationCurve: Curves.fastOutSlowIn,
                  dotSpacing: 15.0,
                  dotColor: Colors.lightGreenAccent,
                  indicatorBgPadding: 5.0,
                  dotBgColor: Colors.purple.withOpacity(0.5),
                  borderRadius: false,
                  moveIndicatorFromBottom: 180.0,
                  noRadiusForIndicator: true,
                  overlayShadow: true,
                  overlayShadowColors: Colors.white,
                  overlayShadowSize: 0.7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 180,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryWidget(
                        index: index,
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Popular Brands',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    Spacer(),
                    FlatButton(
                        onPressed: () {},
                        child: Text(
                          'View All...',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.red),
                        ))
                  ],
                ),
              ),
              Container(
                height: 210,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Swiper(
                  viewportFraction: 0.8,
                  scale: 0.9,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          color: Colors.blueGrey,
                          child: Image.asset(
                            _brandImages[index],
                            fit: BoxFit.fill,
                          )),
                    );
                  },
                  itemCount: _brandImages.length,
                  autoplay: true,
                  onTap: (index) {
                    Navigator.of(context).pushNamed(
                      BrandNavigationRailScreen.routeName,
                      arguments: {
                        index,
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Popular Products',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    Spacer(),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(FeedsScreen.routeName, arguments: 'popular');
                        },
                        child: Text(
                          'View All...',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.red),
                        ))
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 285,
                margin: EdgeInsets.symmetric(horizontal: 3),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider.value(value: popularItems[index], child: PopularProducts());
                    }),
              )
            ],
          ),
        ),
        backLayer: Center(
          child: BackLayerMenu(),
        ),
      ),
    );
  }
}
