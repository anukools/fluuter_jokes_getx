import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jokes_app/core/controllers/base_controller.dart';
import 'package:get/get.dart';

class JokeController extends BaseController {
  var jokes = [].obs;
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();

    _startObservingJokes();

    _retrieveJokes();

    startTimer();
  }

  void _startObservingJokes() async {
    Stream<Future<List<String>>> stream = await jokeListUseCase.stream();
    stream.listen((event) async {
      List<String> list = await event;
      jokes.value = list;
    });
  }

  void _retrieveJokes() async {
    List<String> list = await jokeListUseCase.retrieveJokes();
    jokes.value = list;
  }

  void startTimer() {
    const oneMin = Duration(minutes: 1);
    _timer = Timer.periodic(
      oneMin, (Timer timer) {
          debugPrint('call API to get new Jokes.');

          /// make API call to get new Joke
          _retrieveJokes();
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}