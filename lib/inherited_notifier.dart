import 'package:flutter/material.dart';

class MyInheritNotifier extends StatelessWidget {
  const MyInheritNotifier({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: SliderInheritedNotifier(
        sliderData: sliderdata,
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Slider(
                  value: SliderInheritedNotifier.of(context),
                  onChanged: (value) {
                    sliderdata.value = value;
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Opacity(
                      opacity: SliderInheritedNotifier.of(context),
                      child: Container(
                        color: Colors.yellow,
                        height: 200,
                      ),
                    ),
                    Opacity(
                      opacity: SliderInheritedNotifier.of(context),
                      child: Container(
                        color: Colors.blue,
                        height: 200,
                      ),
                    ),
                  ].expandEqually().toList(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

final sliderdata = SliderData();

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  const SliderInheritedNotifier({
    Key? key,
    required Widget child,
    required SliderData sliderData,
  }) : super(key: key, child: child, notifier: sliderData);

  static double of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()
          ?.notifier
          ?.value ??
      0.0;
}

//state manager
class SliderData extends ChangeNotifier {
  double _value = 0.0;
  double get value => _value;
  set value(double newValue) {
    if (newValue != value) {
      _value = newValue;
      notifyListeners();
    }
  }
}

//expanding row widget to get the whole width of the screen and distribute it's size to the children equally.
extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandEqually() => map((w) => Expanded(child: w));
}

/* 
InheritedNotifier is a variant of InheritedWidget
It's customized mainly for ChangeNotifier and ValueNotifier

ChangeNotifier - holds on to the state
InheritedNotifier - Rebuild the child
*/