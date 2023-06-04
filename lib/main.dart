import 'package:flutter/material.dart';
import 'dart:math' show pi;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Offset> _offsetAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
    _offsetAnimation = TweenSequence<Offset>([
      TweenSequenceItem<Offset>(
          weight: 2,
          tween: Tween<Offset>(
              begin: Offset(0, 100 * pi), end: Offset(pi * 100, 5))),
      TweenSequenceItem<Offset>(
          weight: 2,
          tween: Tween<Offset>(
              begin: Offset(pi * 100, 5), end: Offset(0, 100 * pi))),
    ]).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Build method');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            //alignment: Alignment.topLeft,
            //transform: Matrix4.identity()..,
            offset: _offsetAnimation.value,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateZ(_animation.value),
              child: child,
            ),
          );
        },
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 7,
                  spreadRadius: 2,
                )
              ]),
        ),
      ),
    );
  }
}
