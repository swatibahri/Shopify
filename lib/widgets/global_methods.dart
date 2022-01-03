import 'package:flutter/material.dart';

class GlobalMethods {
  Future<void> showDialogBox(BuildContext context, String title, String subtitle, Function fct) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Image.network(
                    'https://img.favpng.com/2/19/4/warning-icon-png-favpng-veQsyiL347EWdmLs2ajhCUP2f.jpg',
                    height: 30,
                    width: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title),
                ),
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    fct();
                    Navigator.pop(context);
                  },
                  child: Text('OK')),
            ],
          );
        });
  }
}
