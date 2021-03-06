import 'package:flutter/material.dart';
import 'package:store_app/inner_screens/upload_product_form.dart';
import 'package:store_app/screens/landing_page.dart';

import 'bottom_bar.dart';

class MainScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen(), UploadProductForm()],
    );
  }
}
