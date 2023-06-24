import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ApiProvider extends InheritedWidget {
  final Api api;
  final String uuid;

  ApiProvider({
    Key? key,
    required this.api,
    required Widget child,
  })  : uuid = const Uuid().v4(),
        super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    return uuid != oldWidget.uuid;
  }

  //A way for dependants to get an instance
  static ApiProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
}

class MyInheritWidget extends StatefulWidget {
  const MyInheritWidget({super.key});

  @override
  State<MyInheritWidget> createState() => _MyInheritWidgetState();
}

class _MyInheritWidgetState extends State<MyInheritWidget> {
  ValueKey _textKey = const ValueKey<String?>(null);

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return ApiProvider(
      api: Api(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(ApiProvider.of(context).api.dateAndTime ?? ''),
        ),
        body: GestureDetector(
          onTap: () async {
            final dateAndTime = await api.getDateAndTime();
            setState(() {
              _textKey = ValueKey(dateAndTime);
            });
          },
          child: SizedBox.expand(
            child: Container(
              color: Colors.white,
              child: Text(
                  key: _textKey,
                  api.dateAndTime ?? 'Tap on screen to fetch date and time'),
            ),
          ),
        ),
      ),
    );
  }
}

class Api {
  String? dateAndTime;

  Future<String> getDateAndTime() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => DateTime.now().toIso8601String(),
    ).then((value) {
      dateAndTime = value;
      return value;
    });
  }
}
