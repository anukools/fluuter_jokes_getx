import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jokes_app/core/widgets/base_screen_widget.dart';
import 'package:jokes_app/screens/joke/joke_controller.dart';
import 'package:jokes_app/screens/joke/joke_widget.dart';
import 'package:get/get.dart';

class JokeListPage extends BaseScreenWidget {
  JokeListPage({required super.widgetKey, required super.params}) : super();

  @override
  Widget buildView(BuildContext context) {
    return GetX<JokeController>(
        init: JokeController(),
        builder: (myController) =>
        (
            myController.jokes.isNotEmpty
                ? ListView.builder(
                itemCount: myController.jokes.length,
                itemBuilder: (context, index) {
                  return JokeListItem(message: myController.jokes[index]);
                })
                : const Center(
              child: Text('No jokes yet.'),
            )
        )
    );
  }
}
