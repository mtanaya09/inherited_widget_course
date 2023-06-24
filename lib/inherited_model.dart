import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:state_management_part_2/colors/colors.dart';


class MyInheritModel extends StatefulWidget {
  const MyInheritModel({super.key});

  @override
  State<MyInheritModel> createState() => _MyInheritModelState();
}

class _MyInheritModelState extends State<MyInheritModel> {
  var color1 = Colors.yellow;
  var color2 = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home page'),
        ),
        body: AvailableColorsWidget(
          color1: color1,
          color2: color2,
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        color1 = colors.getRandomElement();
                      });
                    },
                    child: const Text('Change color1'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        color2 = colors.getRandomElement();
                      });
                    },
                    child: const Text('Change color2'),
                  ),
                ],
              ),
              const ColorWidget(color: AvailableColors.one),
              const ColorWidget(color: AvailableColors.two),
            ],
          ),
        ));
  }
}

enum AvailableColors { one, two }

//color providers
class AvailableColorsWidget extends InheritedModel<AvailableColors> {
  final MaterialColor color1;
  final MaterialColor color2;

  const AvailableColorsWidget({
    Key? key,
    required this.color1,
    required this.color2,
    required Widget child,
  }) : super(key: key, child: child);

  //allow grabing a copy
  static AvailableColorsWidget of(
    BuildContext context,
    AvailableColors aspect,
  ) {
    return InheritedModel.inheritFrom<AvailableColorsWidget>(
      context,
      aspect: aspect,
    )!;
  }

  @override
  bool updateShouldNotify(covariant AvailableColorsWidget oldWidget) {
    devtools.log('updateShouldNotify');
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(covariant AvailableColorsWidget oldWidget,
      Set<AvailableColors> dependencies) {
    devtools.log('updateShouldNotifyDependent');
    if (dependencies.contains(AvailableColors.one) &&
        color1 != oldWidget.color1) {
      return true;
    }
    if (dependencies.contains(AvailableColors.two) &&
        color2 != oldWidget.color2) {
      return true;
    }
    return false;
  }
}

class ColorWidget extends StatelessWidget {
  final AvailableColors color;
  const ColorWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case AvailableColors.one:
        devtools.log('Color1 widget got rebuild');
        break;
      case AvailableColors.two:
        devtools.log('Color2 widget got rebuild');
        break;
    }

    final provider = AvailableColorsWidget.of(context, color);

    return Container(
      height: 100,
      color: color == AvailableColors.one ? provider.color1 : provider.color2,
    );
  }
}

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        Random().nextInt(length),
      );
}

/* 
How will we manage the state?

Our StatefulWidget will create an instance of our Inherited model which itself is an 
Inherited Widget
*/
